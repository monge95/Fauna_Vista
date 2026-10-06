//
//  missionpin.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 02/10/26.
//

import SwiftUI

struct MissionPin: Identifiable {
    let id: UUID = UUID()
    let biomeId: Int
    
    let animalName: String
    let assetsName: String
    let assetsNameDiscovered: String
    
    let missionObjective1: String
    let missionObjective2: String
    let missionObjective3: String
    
    let posX: CGFloat
    let posY: CGFloat
    
    static let allMissionPins: [MissionPin] = [
        // CERRADO
        MissionPin(biomeId: 1, animalName: "Lobo-guará", assetsName: "PinLobo",assetsNameDiscovered: "pinLoboDiscovered",
                   missionObjective1: "O guardião do cerrado",
                   missionObjective2: "O lobo-guará está escondido entre o capim-dourado.",
                   missionObjective3: "Fotografe o lobo sem assustá-lo",
                   posX: 350.0, posY: 158.0),
        
        MissionPin(biomeId: 1, animalName: "Tamanduá-bandeira", assetsName: "PinTamandua",assetsNameDiscovered: "pinTamanduaDiscovered",
                   missionObjective1: "O jardineiro do cerrado",
                   missionObjective2: "O tamanduá cava cupinzeiros e fertiliza o solo.",
                   missionObjective3: "Fotografe o tamanduá se alimentando",
                   posX: 262.0, posY: 285.0),
        
        // AMAZÔNIA
        MissionPin(biomeId: 2, animalName: "Boto-cor-de-rosa", assetsName: "PinBoto",assetsNameDiscovered: "pinBotoDiscovered",
                   missionObjective1: "A lenda do rio",
                   missionObjective2: "O boto aparece no rio quando o sol se põe.",
                   missionObjective3: "Fotografe o boto na superfície",
                   posX: 280.0, posY: 100.0),
        MissionPin(biomeId: 2, animalName: "Uacari-vermelho", assetsName: "PinUacari",assetsNameDiscovered: "pinDiscovered",
                   missionObjective1: "O desenho do céu",
                   missionObjective2: "As araras voam em dupla pela copa densa.",
                   missionObjective3: "Fotografe a arara voando",
                   posX: 108.0, posY: 140.0),
        // PAMPA
        MissionPin(biomeId: 3, animalName: "Veste-amarela", assetsName: "PinVeste",assetsNameDiscovered: "pinVesteDiscovered",
                   missionObjective1: "O sentinela dos campos",
                   missionObjective2: "O quero-quero avisa todo mundo quando alguém chega.",
                   missionObjective3: "Fotografe o quero-quero no chão",
                   posX: 237.0, posY: 405.0),
        MissionPin(biomeId: 3, animalName: "Sapo-de-chifres", assetsName: "PinSapo",assetsNameDiscovered: "pinSapoDiscovered",
                   missionObjective1: "O corredor do pampa",
                   missionObjective2: "O veado corre livre entre os campos abertos.",
                   missionObjective3: "Fotografe o veado em movimento",
                   posX: 260.0, posY: 460.0),
        // MATA ATLÂNTICA
        MissionPin(biomeId: 4, animalName: "Mico-leão-dourado", assetsName: "PinMico",assetsNameDiscovered: "pinMicoDiscovered",
                   missionObjective1: "O tesouro da floresta",
                   missionObjective2: "O mico vive só nas copas da Mata Atlântica.",
                   missionObjective3: "Fotografe o mico na árvore",
                   posX: 392.0, posY: 280.0),
        MissionPin(biomeId: 4, animalName: "Preguiça-de-coleira", assetsName: "PinPreguiça",assetsNameDiscovered: "pinPreguiçaDiscovered",
                   missionObjective1: "A plantadora de araucárias",
                   missionObjective2: "A gralha enterra pinhões e planta novas árvores.",
                   missionObjective3: "Fotografe a gralha perto da araucária",
                   posX: 280.0, posY: 380.0),
        // CAATINGA
        MissionPin(biomeId: 5, animalName: "Tatu-bola", assetsName: "PinTatu",assetsNameDiscovered: "pinTatuDiscovered",
                   missionObjective1: "O campeão da defesa",
                   missionObjective2: "O tatu-bola se enrola numa bola perfeita.",
                   missionObjective3: "Fotografe o tatu enrolado",
                   posX: 400.0, posY: 210.0),
        MissionPin(biomeId: 5, animalName: "Arara-azul-de-lear", assetsName: "PinArara",assetsNameDiscovered: "pinAraraDiscovered",
                   missionObjective1: "A joia da caatinga",
                   missionObjective2: "Essa arara só existe na caatinga brasileira.",
                   missionObjective3: "Fotografe a arara azul",
                   posX: 410.0, posY: 150.0),
        // PANTANAL
        MissionPin(biomeId: 6, animalName: "Onça-pintada", assetsName: "PinOnça",assetsNameDiscovered: "pinOnçaDiscovered",
                   missionObjective1: "A rainha do pantanal",
                   missionObjective2: "A onça é a maior felina das Américas.",
                   missionObjective3: "Fotografe a onça à beira do rio",
                   posX: 225.0, posY: 260.0),
        MissionPin(biomeId: 6, animalName: "Ariranha", assetsName: "PinAriranha",assetsNameDiscovered: "pinAriranhaDiscovered",
                   missionObjective1: "O gigante azul",
                   missionObjective2: "A maior arara do mundo vive no pantanal.",
                   missionObjective3: "Fotografe a arara no buriti",
                   posX: 205.0, posY: 310.0)
    ]
}
