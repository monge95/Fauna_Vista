//
//  ExpeditionViewState.swift
//  FaunaVista
//
//  Camada VIEW da expedição: tudo que é de tela e de infraestrutura
//  (timer, cena 3D, flash, recorte, mira, debug).
//  As regras do jogo ficam no Model (ExpeditionGame).
//

import SwiftUI
import UIKit
import RealityKit
import Observation

@MainActor
@Observable
final class ExpeditionViewState {

    // MARK: - Model

    let game = ExpeditionGame()

    // Leitura do Model (as Views usam vm.gameState, vm.photoCards...)
    var gameState: ExpeditionGameState { game.gameState }
    var timeRemaining: TimeInterval { game.timeRemaining }
    var photosTaken: Int { game.photosTaken }
    var photoCards: [ExpeditionPhoto] { game.photoCards }
    var selectedPhotoIDs: [UUID] { game.selectedPhotoIDs }
    var level: ExpeditionLevel? { game.level }

    var missionAnimal: ExpeditionAnimalDefinition? { game.missionAnimal }
    var requiredSelection: Int { game.requiredSelection }
    var selectedPhotos: [ExpeditionPhoto] { game.selectedPhotos }
    var canSubmitSelection: Bool { game.canSubmitSelection }
    var missionResults: [(mission: ExpeditionMission, completed: Bool)] { game.missionResults }
    var allMissionsCompleted: Bool { game.allMissionsCompleted }

    // MARK: - Estado de apresentação

    private(set) var photoFlashID = 0
    var cropRect: CGRect = .zero
    var isDetectedObjectScorable = true

    var mapLoaded = false
    var travelDistance: Float = 0
    var travelDuration: TimeInterval = 0

    // Debug da mira central.
    var detectedObjectName = "Nenhum objeto"
    var detectedObjectDistance: Float?
    var detectedObjectStars = 0
    var isTargetDetected = false
    var isVegetationDetected = false

    // Ajuste manual da mira (ver ExpeditionConfig.aimDetectionOffset...).
    var aimOffsetMinZoom = ExpeditionConfig.aimDetectionOffsetAtMinZoom
    var aimOffsetMaxZoom = ExpeditionConfig.aimDetectionOffsetAtMaxZoom
    // Deslocamento efetivo no zoom atual (usado pela bolinha de debug).
    var aimDetectionOffset: CGPoint = .zero

    // MARK: - Infraestrutura (não observada)

    @ObservationIgnored private weak var expeditionView: ExpeditionSceneView?
    @ObservationIgnored private var timer: Timer?
    @ObservationIgnored private var pendingBuild = false

    init() {
        // ExpeditionMapCache.shared.preload()
        // ExpeditionObjectCache.shared.preloadAll()
        // ExpeditionAnimalCache.shared.preloadAll()
    }

    // MARK: - Nível

    func configure(level: ExpeditionLevel) {
        guard game.setLevel(level) else { return }
        ExpeditionMapCache.shared.preload(fileName: level.mapFileName)
        ExpeditionObjectCache.shared.preload(modelNames: level.vegetationModelNames)
        if let animal = level.animal {
            ExpeditionAnimalCache.shared.preload(animal)
        }
    }

    // MARK: - Seleção de fotos (delegado ao Model)

    func isSelected(_ photo: ExpeditionPhoto) -> Bool { game.isSelected(photo) }
    func toggleSelection(_ photo: ExpeditionPhoto) { game.toggleSelection(photo) }

    func confirmSelection() { game.confirmSelection() }
    func backToSelection()  { game.backToSelection() }
    func showRegistered()   { game.showRegistered() }

    // MARK: - Cena 3D

    func connect(_ view: ExpeditionSceneView) {
        // Garante que nunca haja duas cenas vivas ao mesmo tempo.
        if let old = expeditionView, old !== view {
            old.teardown()
        }

        expeditionView = view

        if game.gameState == .playing {
            view.buildExpedition()
            pendingBuild = false
        } else {
            buildIfNeeded()
        }
    }

    func buildIfNeeded() {
        guard pendingBuild, let expeditionView else { return }
        pendingBuild = false
        expeditionView.buildExpedition()
        updateMapInformation()
    }

    func updateMapInformation() {
        guard let expeditionView else { return }
        travelDistance = expeditionView.travelDistance
        travelDuration = expeditionView.travelDuration
        mapLoaded = expeditionView.mapLoaded
    }

    // Derruba a ExpeditionSceneView atual e solta a referência a ela.
    private func releaseScene() {
        let view = expeditionView
        expeditionView = nil
        view?.teardown()
    }

    // Chamado pela própria view ao terminar o teardown (inclusive quando o
    // SwiftUI a destrói por conta própria).
    func sceneViewDidTearDown(_ view: ExpeditionSceneView) {
        if expeditionView === view {
            expeditionView = nil
        }
    }

    // MARK: - Mira e detecção

    func adjustAimOffset(atMaxZoom: Bool, deltaY: CGFloat) {
        if atMaxZoom {
            aimOffsetMaxZoom.y += deltaY
        } else {
            aimOffsetMinZoom.y += deltaY
        }
        print("🎯 aimDetectionOffsetAtMinZoom = (x: \(aimOffsetMinZoom.x), y: \(aimOffsetMinZoom.y))")
        print("🎯 aimDetectionOffsetAtMaxZoom = (x: \(aimOffsetMaxZoom.x), y: \(aimOffsetMaxZoom.y))")
    }

    func updateCropRect(_ rect: CGRect) {
        guard rect.width > 0, rect.height > 0 else { return }
        cropRect = rect
    }

    func updateDetection(
        objectName: String?,
        distance: Float?,
        stars: Int,
        isScorable: Bool = true,
        isVegetation: Bool = false
    ) {
        detectedObjectName = objectName ?? "Nenhum objeto"
        detectedObjectDistance = distance
        detectedObjectStars = stars
        isTargetDetected = objectName != nil
        isDetectedObjectScorable = isScorable
        isVegetationDetected = isVegetation && objectName != nil
    }

    // MARK: - Ciclo da partida

    func startGame() {
        stopTimer()

        // Se sobrou alguma cena da partida anterior, derruba antes de começar.
        releaseScene()

        pendingBuild = true
        game.start(duration: ExpeditionConfig.gameDuration)

        startTimer()
        buildIfNeeded()
    }

    func finishGame() {
        stopTimer()

        // Se há uma foto sendo processada, o Model adia o fim; capturePhoto()
        // chama finishGame() de novo quando a foto fechar.
        guard game.finish() else { return }

        // Encerra a cena 3D de verdade (display link, animações, entidades).
        releaseScene()
    }

    func returnToStart() {
        stopTimer()

        // Normalmente a cena já foi liberada em finishGame(); isto é só
        // uma garantia (a chamada é idempotente).
        releaseScene()

        game.returnToStart()
        updateDetection(objectName: nil, distance: nil, stars: 0)
    }

    // MARK: - Timer

    private func startTimer() {
        let newTimer = Timer(timeInterval: 0.1, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.tick()
            }
        }

        RunLoop.main.add(newTimer, forMode: .common)
        timer = newTimer
    }

    private func tick() {
        switch game.tick() {
        case .stopTimer: stopTimer()
        case .expired:   finishGame()
        case .running:   break
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    // MARK: - Captura de foto

    func capturePhoto() {
        guard let expeditionView, game.beginCapture() else { return }

        photoFlashID += 1
        playPhotoClickSound()

        Task { @MainActor in
            let result = await expeditionView.captureCurrentView(cropRect: cropRect)

            let photo = ExpeditionPhoto(
                image: result.image, stars: result.stars, objectName: result.objectName,
                distance: result.distance, isScorable: result.isScorable,
                animalID: result.animalID, pose: result.pose
            )

            if game.completeCapture(photo) {
                finishGame()
            }
        }
    }

    // MARK: - Som do clique da foto
    private func playPhotoClickSound() {
        // TODO: introduzir aqui o som do obturador.
        // Este método é chamado uma única vez por foto aceita, junto ao flash.
        // Exemplo futuro: carregar e reproduzir um arquivo de áudio do app.
    }

    // MARK: - Controles de debug
    // Move o objeto atualmente em foco na mira ao longo do eixo escolhido.
    // direction: +1 para o sentido positivo do eixo, -1 para o negativo.
    func debugMoveFocusedObject(axis: ExpeditionDebugAxis, direction: Float) {
        expeditionView?.debugMoveFocusedObject(
            axis: axis,
            delta: direction * ExpeditionConfig.debugObjectMoveStep
        )
    }

    // Sobe (direction = +1) ou desce (direction = -1) a câmera.
    func debugMoveCamera(direction: Float) {
        expeditionView?.debugMoveCamera(
            verticalDelta: direction * ExpeditionConfig.debugCameraMoveStep
        )
    }
}//
//  ExpeditionViewState.swift
//  FaunaVista
//
//  Created by Felipe Colares Cardoso on 08/10/26.
//

