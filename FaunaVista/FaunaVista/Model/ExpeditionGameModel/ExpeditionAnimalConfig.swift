//
//  ExpeditionAnimalConfig.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//


import SwiftUI
import UIKit
import RealityKit
import Combine


struct ExpeditionAnimalConfig {
    // EDITE ESTA LISTA PARA ADICIONAR MAIS ANIMAIS
    // tamandua_all.usdz
    // 0...50    = Idle
    // 51...100  = Walking
    // 101...140 = Action
    static let animals: [ExpeditionAnimalDefinition] = [
        ExpeditionAnimalDefinition(
            id: "animal_1",
            modelName: "tamandua_all",
            displayName: "Tamanduá Bandeira",
            scientificName: "Myrmecophaga tridactyla",
            enabled: true,
            speed: 3.4,
            waitAtPosition: 2.0,
            actionDuration: 7.0,
            loopRoute: true,
            randomActionEnabled: true,
            randomActionChance: 0.35,
            animationTimelineStartFrame: 0,
            animationTimelineEndFrame: 140,
            idleStartFrame: 0,
            idleEndFrame: 50, // pode mudar de animal pra animal
            walkingStartFrame: 51, // pode mudar de animal pra animal
            walkingEndFrame: 100, // pode mudar de animal pra animal
            actionStartFrame: 101,// pode mudar de animal pra animal
            actionEndFrame: 140,// pode mudar de animal pra animal
            idleLoops: true, // Idle e Walking ficam em loop.
            walkingLoops: true,  // Action toca uma vez e depois volta para Idle.
            actionLoops: false,
            modelFacesRight: true,// A rota do tamanduá é comparada com a horizontal visível
            movementAxis: .screen, // da câmera, não com um eixo fixo do mapa.
            detectionOffset: SIMD3<Float>(1.4,0,1.5), // Se o USDZ original olhar para a esquerda, use false. onde Z é pra cima e pra baixo
            detectionScaleX: 5.5,
            detectionScaleY: 3.2,
            detectionVisible: false,
        )
        // Exemplo para adicionar outro animal
        // ExpeditionAnimalDefinition(
        //     id: "animal_2",
        //     modelName: "arara_all",
        //     displayName: "Arara",
        //     speed: 1.5,
        //     waitAtPosition: 3.0,
        //     actionDuration: 4.0,
        //     loopRoute: true,
        //     randomActionEnabled: true,
        //     randomActionChance: 0.30,
        //     animationTimelineStartFrame: 0,
        //     animationTimelineEndFrame: 200,
        //     idleStartFrame: 0,
        //     idleEndFrame: 60,
        //     walkingStartFrame: 61,
        //     walkingEndFrame: 130,
        //     actionStartFrame: 131,
        //     actionEndFrame: 200,
        //     idleLoops: true,
        //     walkingLoops: true,
        //     actionLoops: false
        // )
    ]
    static let randomizeActionPoint = true  // Se true, escolhe aleatoriamente entre os posAction encontrados.
    static let randomizeRoute = false  // false = segue pos1, pos2, pos3.  // true = embaralha a ordem das posições encontradas.
    static let actionEveryWaypoints: Int = 2 // Se > 0 e randomActionEnabled = false: // 2 = faz ação a cada 2 posições, 3 = a cada 3 posições etc.
}
