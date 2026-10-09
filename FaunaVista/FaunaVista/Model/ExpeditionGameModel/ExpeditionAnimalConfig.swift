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
        ExpeditionAnimalDefinition( // tamandua bandeira - Cerrado
            id: "animal_1",
            modelName: "tamandua_bandeira",
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
            animationTimelineEndFrame: 203,
            idleStartFrame: 0,
            idleEndFrame: 50, // pode mudar de animal pra animal
            walkingStartFrame: 51, // pode mudar de animal pra animal
            walkingEndFrame: 100, // pode mudar de animal pra animal
            actionStartFrame: 101,// pode mudar de animal pra animal
            actionEndFrame: 203,// pode mudar de animal pra animal
            idleLoops: true, // Idle e Walking ficam em loop.
            walkingLoops: true,  // Action toca uma vez e depois volta para Idle.
            actionLoops: false,
            modelFacesRight: true,// A rota do tamanduá é comparada com a horizontal visível
            movementAxis: .screen, // da câmera, não com um eixo fixo do mapa.
            detectionOffset: SIMD3<Float>(1.4,0,1.5), // Se o USDZ original olhar para a esquerda, use false. onde Z é pra cima e pra baixo
            detectionScaleX: 5.5,
            detectionScaleY: 3.2,
            detectionVisible: false,
        ),
        ExpeditionAnimalDefinition( // lobo guará - Cerrado
            id: "animal_2",
            modelName: "lobo_guara",
            displayName: "Lobo-Guará",
            scientificName: "Chrysocyon brachyurus",
            enabled: true,
            speed: 7.4,
            waitAtPosition: 2.0,
            actionDuration: 7.0,
            loopRoute: true,
            randomActionEnabled: true,
            randomActionChance: 0.35,
            animationTimelineStartFrame: 1,
            animationTimelineEndFrame: 400,
            idleStartFrame: 1,
            idleEndFrame: 123, // pode mudar de animal pra animal
            walkingStartFrame: 124, // pode mudar de animal pra animal
            walkingEndFrame: 144, // pode mudar de animal pra animal
            actionStartFrame: 145,// pode mudar de animal pra animal
            actionEndFrame: 400,// pode mudar de animal pra animal
            idleLoops: true, // Idle e Walking ficam em loop.
            walkingLoops: true,  // Action toca uma vez e depois volta para Idle.
            actionLoops: false,
            modelFacesRight: true,// A rota do tamanduá é comparada com a horizontal visível
            movementAxis: .screen, // da câmera, não com um eixo fixo do mapa.
            detectionOffset: SIMD3<Float>(1.4,0,1.5), // Se o USDZ original olhar para a esquerda, use false. onde Z é pra cima e pra baixo
            detectionScaleX: 5.5,
            detectionScaleY: 3.2,
            detectionVisible: false,
        ),
        ExpeditionAnimalDefinition( // boto cor de rosa AMAZONIA
            id: "animal_3",
            modelName: "boto_cor_de_rosa",
            displayName: "Boto-cor-de-rosa",
            scientificName: "Inia geoffrensis",
            enabled: true,
            speed: 3.4,
            waitAtPosition: 2.0,
            actionDuration: 7.0,
            loopRoute: true,
            randomActionEnabled: true,
            randomActionChance: 0.35,
            animationTimelineStartFrame: 0,
            animationTimelineEndFrame: 145,
            idleStartFrame: 0,
            idleEndFrame: 33, // pode mudar de animal pra animal
            walkingStartFrame: 0, // pode mudar de animal pra animal
            walkingEndFrame: 33, // pode mudar de animal pra animal
            actionStartFrame: 34,// pode mudar de animal pra animal
            actionEndFrame: 147,// pode mudar de animal pra animal
            idleLoops: true, // Idle e Walking ficam em loop.
            walkingLoops: true,  // Action toca uma vez e depois volta para Idle.
            actionLoops: false,
            modelFacesRight: true,// A rota do tamanduá é comparada com a horizontal visível
            movementAxis: .screen, // da câmera, não com um eixo fixo do mapa.
            detectionOffset: SIMD3<Float>(1.4,0,1.5), // Se o USDZ original olhar para a esquerda, use false. onde Z é pra cima e pra baixo
            detectionScaleX: 5.5,
            detectionScaleY: 3.2,
            detectionVisible: false,
        ),
        ExpeditionAnimalDefinition( // uacari vermehlo - AMAZONIA
            id: "animal_4",
            modelName: "uacari_vermelho",
            displayName: "Uacari-vermelho",
            scientificName: "Cacajao rubicundus",
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
        ),
        ExpeditionAnimalDefinition( // arara azul
            id: "animal_5",
            modelName: "veste_amarela",
            displayName: "Veste-amarela",
            scientificName: "Xanthopsar flavus",
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
        ),
        ExpeditionAnimalDefinition( // sapo de chifres - PAMPA
            id: "animal_6",
            modelName: "sapo_de_chifres",
            displayName: "Sapo-de-chifres",
            scientificName: "Ceratophrys ornata",
            enabled: true,
            speed: 3.4,
            waitAtPosition: 3.0,
            actionDuration: 7.0,
            loopRoute: true,
            randomActionEnabled: true,
            randomActionChance: 0.35,
            animationTimelineStartFrame: 0,
            animationTimelineEndFrame: 134,
            idleStartFrame: 0,
            idleEndFrame: 41, // pode mudar de animal pra animal
            walkingStartFrame: 41, // pode mudar de animal pra animal
            walkingEndFrame: 60, // pode mudar de animal pra animal
            actionStartFrame: 61,// pode mudar de animal pra animal
            actionEndFrame: 134,// pode mudar de animal pra animal
            idleLoops: true, // Idle e Walking ficam em loop.
            walkingLoops: true,  // Action toca uma vez e depois volta para Idle.
            actionLoops: false,
            modelFacesRight: true,// A rota do tamanduá é comparada com a horizontal visível
            movementAxis: .screen, // da câmera, não com um eixo fixo do mapa.
            detectionOffset: SIMD3<Float>(1.4,0,1.5), // Se o USDZ original olhar para a esquerda, use false. onde Z é pra cima e pra baixo
            detectionScaleX: 5.5,
            detectionScaleY: 3.2,
            detectionVisible: false,
        ),
        ExpeditionAnimalDefinition(
            id: "animal_7",
            modelName: "mico_leao_dourado",
            displayName: "Mico-leão-dourado",
            scientificName: "Leontopithecus rosalia",
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
        ),
        ExpeditionAnimalDefinition(
            id: "animal_8",
            modelName: "preguica_de_coleira",
            displayName: "Preguiça-de-coleira",
            scientificName: "Bradypus torquatus",
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
        ),
        ExpeditionAnimalDefinition(
            id: "animal_9",
            modelName: "arara_azul",
            displayName: "Arara-Azul",
            scientificName: "Anodorhynchus leari",
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
        ),
        ExpeditionAnimalDefinition(
            id: "animal_10",
            modelName: "tatu_bola",
            displayName: "Tatu-bola",
            scientificName: "Tolypeutes tricinctus",
            enabled: true,
            speed: 6,
            waitAtPosition: 0.9,
            actionDuration: 7.0,
            loopRoute: true,
            randomActionEnabled: true,
            randomActionChance: 0.35,
            animationTimelineStartFrame: 1,
            animationTimelineEndFrame: 200,
            idleStartFrame: 0,
            idleEndFrame: 50, // pode mudar de animal pra animal
            walkingStartFrame: 51, // pode mudar de animal pra animal
            walkingEndFrame: 73, // pode mudar de animal pra animal
            actionStartFrame: 75,// pode mudar de animal pra animal
            actionEndFrame: 200,// pode mudar de animal pra animal
            idleLoops: true, // Idle e Walking ficam em loop.
            walkingLoops: true,  // Action toca uma vez e depois volta para Idle.
            actionLoops: false,
            modelFacesRight: true,// A rota do tamanduá é comparada com a horizontal visível
            movementAxis: .screen, // da câmera, não com um eixo fixo do mapa.
            detectionOffset: SIMD3<Float>(1.4,0,1.5), // Se o USDZ original olhar para a esquerda, use false. onde Z é pra cima e pra baixo
            detectionScaleX: 5.5,
            detectionScaleY: 3.2,
            detectionVisible: false,
        ),
        ExpeditionAnimalDefinition(
            id: "animal_11",
            modelName: "ariranha",
            displayName: "Ariranha",
            scientificName: "Pteronura brasiliensis",
            enabled: true,
            speed: 12.4,
            waitAtPosition: 2.0,
            actionDuration: 3.0,
            loopRoute: true,
            randomActionEnabled: true,
            randomActionChance: 0.35,
            animationTimelineStartFrame: 0,
            animationTimelineEndFrame: 173,
            idleStartFrame: 1,
            idleEndFrame: 77, // pode mudar de animal pra animal
            walkingStartFrame: 82, // pode mudar de animal pra animal
            walkingEndFrame: 125, // pode mudar de animal pra animal
            actionStartFrame: 126,// pode mudar de animal pra animal
            actionEndFrame: 173,// pode mudar de animal pra animal
            idleLoops: true, // Idle e Walking ficam em loop.
            walkingLoops: true,  // Action toca uma vez e depois volta para Idle.
            actionLoops: false,
            modelFacesRight: true,// A rota do tamanduá é comparada com a horizontal visível
            movementAxis: .screen, // da câmera, não com um eixo fixo do mapa.
            detectionOffset: SIMD3<Float>(1.4,0,1.5), // Se o USDZ original olhar para a esquerda, use false. onde Z é pra cima e pra baixo
            detectionScaleX: 5.5,
            detectionScaleY: 3.2,
            detectionVisible: false,
        ),
        ExpeditionAnimalDefinition(
            id: "animal_12",
            modelName: "onca_pintada",
            displayName: "Onça-pintada",
            scientificName: "Panthera onca",
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
