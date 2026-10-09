//
//  ExpeditionConfig.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine


// MARK: - CONFIGURAÇÃO DO FAUNA VISTA
struct ExpeditionConfig {
    static let mapFileName = "MapaCerrado" // "FaunaVistaMap" , vai variar de acordo com o mapa selecionado
    static let mapFileExtension = "usdz"
    static let cameraSpeed: Float = 35
    static let lookSensitivity: Float = 0.006 // sensibilidade no zoom mínimo (1x)
    static let lookSensitivityAtMaxZoom: Float = 0.001 // sensibilidade no zoom máximo (5x)
    static let cameraFieldOfView: CGFloat = 65
    static let minimumZoom: Float = 1  // Zoom óptico da câmera. 1.0 = sem zoom. 5 para permitir aproximar mais.
    static let maximumZoom: Float = 5.0
    static let totalPhotos = 10
    static let gameDuration: TimeInterval = 60

    // MARK: - Transição para iniciar a expedição
    // Estes valores podem ser alterados livremente para ajustar a experiência.
    static let startCountdownDuration: TimeInterval = 3.0
    static let startCountdownStepDuration: TimeInterval = 1.0
    static let startFadeInDuration: TimeInterval = 0.45
    static let startFadeOutDuration: TimeInterval = 0.45
    static let photoCropSize: CGFloat = 280  // Tamanho do quadro de captura.
    // Distância válida para detectar um objeto.
    // Ajuste estes dois valores conforme o tamanho real dos seus modelos 3D.
    static let minimumCaptureDistance: Float =  0 //  se o animal for do tamanho do Animal do prototipo
    static let maxCaptureDistance: Float = 220.0
    static let aimPointRadius: CGFloat = 9 // Raio do ponto central da mira.
    // AJUSTE MANUAL DO PONTO DE DETECÇÃO (em pontos de tela, relativo à mira desenhada).
    // y NEGATIVO = a detecção sobe; y POSITIVO = desce. x NEGATIVO = esquerda.
    // O valor é interpolado entre o zoom mínimo (1x) e o máximo (5x).
    // Use o painel "Ajuste da mira" na tela e copie aqui os valores impressos no console.
    static let aimDetectionOffsetAtMinZoom = CGPoint(x: 0, y: -40) // calibrado!!
    static let aimDetectionOffsetAtMaxZoom = CGPoint(x: 0, y: 50) // calibrado!
    static let aimTuningPanelVisible = true   // painel de ajuste ao vivo
    static let aimDebugMarkerVisible = true   // bolinha ciano = ponto REAL da detecção
    static let aimTuningStep: CGFloat = 10    // passo de cada toque, em pontos
    // Detecção da vegetação: usa um detector próprio baseado no tamanho
    // visual do modelo, sem depender das colisões do mesh original.
    static let vegetationDetectionVisible = true
    static let vegetationDetectionPadding: Float = 0.00
    static let vegetationDetectionOffset = SIMD3<Float>(0, -5, 0) // posicao da caixa de colisao da vegetacao
    static let debugObjectMoveStep: Float = 0.5  // Passo dos controles de debug (em metros).
    static let debugCameraMoveStep: Float = 0.5 // Distância ideal = 100 pontos/estrelas máximas.
    static let idealDistanceScore: Float = 100  // Distância máxima = 0 pontos.
    static let minimumDistanceForScore: Float = minimumCaptureDistance
    static let maximumDistanceForScore: Float = maxCaptureDistance
    static let missionMinimumStars = 3
    static let photosToSubmit = 3
    // Ajuste fino do recorte da foto (em pontos de tela).
    // y NEGATIVO = o recorte sobe (foto mostra mais coisas acima).
    // x NEGATIVO = o recorte vai para a esquerda.
    static let photoCropOffset = CGPoint(x: 0, y: -70) // Calibragem do quadro de fotografia
    
    // limitação do angulo da camera em graus
    static let maxLookUpDegrees: Float = 50
    static let maxLookDownDegrees: Float = 50
    static let maxLookLeftDegrees: Float = 50
    static let maxLookRightDegrees: Float = 50
}


