//
//  ExpedtitionAnimalDefinition.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine


struct ExpeditionAnimalDefinition: Identifiable {
    let id: String
    let modelName: String
    let displayName: String
    let enabled: Bool
    let speed: Float
    let waitAtPosition: TimeInterval
    let actionDuration: TimeInterval
    let loopRoute: Bool
    let randomActionEnabled: Bool
    let randomActionChance: Float
    // UMA ÚNICA ANIMAÇÃO CONTÍNUA NO USDZ
    // Frames do Blender usados para separar a timeline importada.
    let animationTimelineStartFrame: Int
    let animationTimelineEndFrame: Int
    let idleStartFrame: Int
    let idleEndFrame: Int
    let walkingStartFrame: Int
    let walkingEndFrame: Int
    let actionStartFrame: Int
    let actionEndFrame: Int
    // Cada trecho pode repetir ou tocar uma única vez.
    let idleLoops: Bool
    let walkingLoops: Bool
    let actionLoops: Bool
    // ESPELHAMENTO HORIZONTAL (esquerda / direita)
    // true  = o sprite, SEM nenhum espelhamento, olha para a DIREITA
    //         da tela (mesmo lado do X+ do mundo).
    // false = o sprite, sem espelhamento, olha para a ESQUERDA.
    // O sistema mede o lado real do sprite a cada frame e só espelha
    // quando ele está andando para o lado contrário ao que olha.
    let modelFacesRight: Bool
    let movementAxis: ExpeditionMovementAxis // Referência que define "esquerda" e "direita" na rota.
    let detectionOffset: SIMD3<Float>   // Detector retangular
    let detectionScaleX: Float
    let detectionScaleY: Float
    let detectionVisible: Bool
    let scientificName: String
     
    init(
        id: String,
        modelName: String,
        displayName: String,
        scientificName: String = "",
        enabled: Bool = true,
        speed: Float = 1.0,
        waitAtPosition: TimeInterval = 2.0,
        actionDuration: TimeInterval = 4.0,
        loopRoute: Bool = true,
        randomActionEnabled: Bool = true,
        randomActionChance: Float = 0.35,
        animationTimelineStartFrame: Int = 0,
        animationTimelineEndFrame: Int = 140,
        idleStartFrame: Int = 0,
        idleEndFrame: Int = 50,
        walkingStartFrame: Int = 51,
        walkingEndFrame: Int = 100,
        actionStartFrame: Int = 101,
        actionEndFrame: Int = 140,
        idleLoops: Bool = true,
        walkingLoops: Bool = true,
        actionLoops: Bool = false,
        modelFacesRight: Bool = true,
        movementAxis: ExpeditionMovementAxis = .x,
        detectionOffset: SIMD3<Float> = .zero,
        detectionScaleX: Float = 2.0,
        detectionScaleY: Float = 2.0,
        detectionVisible: Bool = false,
       
        
    ) {
        self.id = id
        self.modelName = modelName
        self.displayName = displayName
        self.scientificName = scientificName
        self.enabled = enabled
        self.speed = speed
        self.waitAtPosition = waitAtPosition
        self.actionDuration = actionDuration
        self.loopRoute = loopRoute
        self.randomActionEnabled = randomActionEnabled
        self.randomActionChance = randomActionChance
        self.animationTimelineStartFrame = animationTimelineStartFrame
        self.animationTimelineEndFrame = animationTimelineEndFrame
        self.idleStartFrame = idleStartFrame
        self.idleEndFrame = idleEndFrame
        self.walkingStartFrame = walkingStartFrame
        self.walkingEndFrame = walkingEndFrame
        self.actionStartFrame = actionStartFrame
        self.actionEndFrame = actionEndFrame
        self.idleLoops = idleLoops
        self.walkingLoops = walkingLoops
        self.actionLoops = actionLoops
        self.modelFacesRight = modelFacesRight
        self.movementAxis = movementAxis
        self.detectionOffset = detectionOffset
        self.detectionScaleX = detectionScaleX
        self.detectionScaleY = detectionScaleY
        self.detectionVisible = detectionVisible
    }

    // Prefixo usado nos Empties do Blender:
    // pos1_animal_1
    // pos2_animal_1
    // posAction_animal_1
    var markerID: String { id }
}
