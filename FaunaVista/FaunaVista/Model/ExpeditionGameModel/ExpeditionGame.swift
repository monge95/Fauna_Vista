//
//  ExpeditionGame.swift
//  FaunaVista
//
//  Created by Felipe Colares Cardoso on 08/10/26.
//

//
//  ExpeditionGame.swift
//  FaunaVista
//
//  MODEL da expedição: estado e regras da partida.
//  Não conhece Timer, RealityKit nem a cena 3D — isso fica no
//  ExpeditionViewState (camada View).
//

import Foundation
import Observation

@Observable
final class ExpeditionGame {

    // MARK: - Resultado de um tick do relógio

    enum TickResult {
        case stopTimer   // partida não está rodando: o timer deve parar
        case running     // segue jogando
        case expired     // o tempo acabou
    }

    // MARK: - Estado

    private(set) var gameState: ExpeditionGameState = .start
    private(set) var level: ExpeditionLevel?
    private(set) var timeRemaining: TimeInterval = 0
    private(set) var photosTaken = 0
    private(set) var photoCards: [ExpeditionPhoto] = []
    private(set) var selectedPhotoIDs: [UUID] = []

    private(set) var captureInProgress = false
    // O tempo acabou enquanto uma foto ainda estava sendo processada:
    // a partida só termina quando essa foto fechar.
    private(set) var finishRequested = false

    @ObservationIgnored private var gameEndDate: Date?

    // MARK: - Derivados

    var missionAnimal: ExpeditionAnimalDefinition? { level?.animal }
    var requiredSelection: Int { min(ExpeditionConfig.photosToSubmit, photoCards.count) }
    var selectedPhotos: [ExpeditionPhoto] { photoCards.filter { selectedPhotoIDs.contains($0.id) } }
    var canSubmitSelection: Bool {
        if requiredSelection == 0 {
            return selectedPhotoIDs.isEmpty
        }
        return selectedPhotoIDs.count == requiredSelection
    }

    var missionResults: [(mission: ExpeditionMission, completed: Bool)] {
        guard let id = missionAnimal?.id else {
            return ExpeditionMission.allCases.map { ($0, false) }
        }
        return ExpeditionMission.allCases.map { ($0, $0.isCompleted(by: selectedPhotos, animalID: id)) }
    }
    
    
    var allMissionsCompleted: Bool { missionResults.allSatisfy { $0.completed } }

    // MARK: - Nível

    /// Retorna `true` se o nível mudou (a View então pré-carrega os assets).
    func setLevel(_ newLevel: ExpeditionLevel) -> Bool {
        guard level?.id != newLevel.id else { return false }
        level = newLevel
        return true
    }

    // MARK: - Seleção de fotos

    func isSelected(_ photo: ExpeditionPhoto) -> Bool {
        selectedPhotoIDs.contains(photo.id)
    }

    func toggleSelection(_ photo: ExpeditionPhoto) {
        if let i = selectedPhotoIDs.firstIndex(of: photo.id) {
            selectedPhotoIDs.remove(at: i)
        } else if selectedPhotoIDs.count < requiredSelection {
            selectedPhotoIDs.append(photo.id)
        }
    }

    // MARK: - Transições de tela

    func confirmSelection() { if canSubmitSelection { gameState = .missionCheck } }
    func backToSelection()  { gameState = .finished }
    func showRegistered()   { gameState = .registered }

    // MARK: - Ciclo da partida

    func start(duration: TimeInterval, now: Date = Date()) {
        photosTaken = 0
        photoCards.removeAll()
        selectedPhotoIDs.removeAll()
        captureInProgress = false
        finishRequested = false

        timeRemaining = duration
        gameEndDate = now.addingTimeInterval(duration)
        gameState = .playing
    }

    func tick(now: Date = Date()) -> TickResult {
        guard gameState == .playing, let end = gameEndDate else {
            return .stopTimer
        }

        let remaining = end.timeIntervalSince(now)

        if remaining <= 0 {
            timeRemaining = 0
            return .expired
        }

        timeRemaining = remaining
        return .running
    }

    // MARK: - Captura de foto

    /// Reserva a captura. Retorna `false` se não for possível tirar foto agora.
    func beginCapture() -> Bool {
        guard
            gameState == .playing,
            !captureInProgress,
            photosTaken < ExpeditionConfig.totalPhotos
        else {
            return false
        }

        captureInProgress = true
        return true
    }

    /// Registra a foto pronta. Retorna `true` se a partida deve terminar agora.
    func completeCapture(_ photo: ExpeditionPhoto) -> Bool {
        photoCards.insert(photo, at: 0)
        photosTaken += 1
        captureInProgress = false

        return finishRequested || photosTaken >= ExpeditionConfig.totalPhotos
    }

    // MARK: - Fim da partida

    /// Retorna `false` quando há uma foto sendo processada: o fim fica pendente
    /// e a View chama `finish()` de novo quando a foto fechar.
    /// Retorna `true` quando a partida terminou de fato (a cena 3D deve ser liberada).
    func finish() -> Bool {
        if captureInProgress {
            finishRequested = true
            return false
        }

        gameEndDate = nil
        timeRemaining = max(0, timeRemaining)
        finishRequested = false
        gameState = .finished
        return true
    }

    func returnToStart() {
        gameEndDate = nil
        finishRequested = false

        gameState = .start
        photosTaken = 0
        timeRemaining = 0
        photoCards.removeAll()
        selectedPhotoIDs.removeAll()
        captureInProgress = false
    }
}


