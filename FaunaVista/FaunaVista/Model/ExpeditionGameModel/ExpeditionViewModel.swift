//
//  ExpeditionViewModel.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine
 
// MARK: - ESTADO DO JOGO

@MainActor
final class ExpeditionViewModel: ObservableObject {
    @Published var gameState: ExpeditionGameState = .start
    @Published var timeRemaining: TimeInterval = 0
    @Published var photosTaken = 0
    @Published var photoCards: [ExpeditionPhoto] = []
    @Published private(set) var photoFlashID = 0
    @Published var cropRect: CGRect = .zero
    @Published var isDetectedObjectScorable = true
    

    @Published var mapLoaded = false
    @Published var travelDistance: Float = 0
    @Published var travelDuration: TimeInterval = 0

    // Debug da mira central.
    @Published var detectedObjectName = "Nenhum objeto"
    @Published var detectedObjectDistance: Float?
    @Published var detectedObjectStars = 0
    @Published var isTargetDetected = false
    @Published var isVegetationDetected = false

    // Ajuste manual da mira (ver ExpeditionConfig.aimDetectionOffset...).
    @Published var aimOffsetMinZoom = ExpeditionConfig.aimDetectionOffsetAtMinZoom
    @Published var aimOffsetMaxZoom = ExpeditionConfig.aimDetectionOffsetAtMaxZoom
    // Deslocamento efetivo no zoom atual (usado pela bolinha de debug).
    @Published var aimDetectionOffset: CGPoint = .zero

    private weak var expeditionView: ExpeditionSceneView?
    private var timer: Timer?
    private var gameEndDate: Date?
    private var pendingBuild = false
    private var captureInProgress = false
    // O tempo acabou enquanto uma foto ainda estava sendo processada:
    // a partida só termina quando essa foto fechar.
    private var finishRequested = false

    init() {
        ExpeditionMapCache.shared.preload()
        ExpeditionObjectCache.shared.preloadAll()
        ExpeditionAnimalCache.shared.preloadAll()
    }

    func connect(_ view: ExpeditionSceneView) {
        // Garante que nunca haja duas cenas vivas ao mesmo tempo.
        if let old = expeditionView, old !== view {
            old.teardown()
        }

        expeditionView = view

        if gameState == .playing {
            view.buildExpedition()
            pendingBuild = false
        } else {
            buildIfNeeded()
        }
    }

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

    func startGame() {
        stopTimer()

        // Se sobrou alguma cena da partida anterior, derruba antes de começar.
        releaseScene()

        photosTaken = 0
        photoCards.removeAll()
        captureInProgress = false
        finishRequested = false
        pendingBuild = true

        let duration = ExpeditionConfig.gameDuration
        timeRemaining = duration
        gameEndDate = Date().addingTimeInterval(duration)
        gameState = .playing

        startTimer()
        buildIfNeeded()
    }

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
        guard gameState == .playing, let end = gameEndDate else {
            stopTimer()
            return
        }

        let remaining = end.timeIntervalSinceNow

        if remaining <= 0 {
            timeRemaining = 0
            finishGame()
        } else {
            timeRemaining = remaining
        }
    }
    
    
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func capturePhoto() {
        guard
            gameState == .playing,
            !captureInProgress,
            photosTaken < ExpeditionConfig.totalPhotos,
            let expeditionView
        else {
            return
        }

        captureInProgress = true
        photoFlashID += 1
        playPhotoClickSound()

        Task { @MainActor in
            let result = await expeditionView.captureCurrentView(cropRect: cropRect)

            photoCards.insert(
                ExpeditionPhoto(
                        image: result.image,
                        stars: result.stars,
                        objectName: result.objectName,
                        distance: result.distance,
                        isScorable: result.isScorable
                    ),
                    at: 0
            )

            photosTaken += 1
            captureInProgress = false

            if finishRequested || photosTaken >= ExpeditionConfig.totalPhotos {
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

    func finishGame() {
        stopTimer()

        // Há uma foto sendo processada: espera ela fechar para não
        // derrubar a cena no meio do snapshot. capturePhoto() chama
        // finishGame() de novo quando terminar.
        if captureInProgress {
            finishRequested = true
            return
        }

        gameEndDate = nil
        timeRemaining = max(0, timeRemaining)
        finishRequested = false

        // Encerra a cena 3D de verdade (display link, animações, entidades).
        releaseScene()

        gameState = .finished
    }

    func returnToStart() {
        stopTimer()
        gameEndDate = nil
        finishRequested = false

        // Normalmente a cena já foi liberada em finishGame(); isto é só
        // uma garantia (a chamada é idempotente).
        releaseScene()

        gameState = .start
        photosTaken = 0
        timeRemaining = 0
        photoCards.removeAll()
        captureInProgress = false
        updateDetection(objectName: nil, distance: nil, stars: 0)
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
}
