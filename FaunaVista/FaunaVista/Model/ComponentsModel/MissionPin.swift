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
    
    let missionTitle: String
    let missionDescription: String
    let missionObjective: String
    
    let posX: CGFloat
    let posY: CGFloat

    static let allMissionPins: [MissionPin] = [
        // CERRADO (biomeId: 1)
        MissionPin(biomeId: 1, animalName: "Lobo-guará",
                   missionTitle: "O guardião do cerrado",
                   missionDescription: "O lobo-guará está escondido entre o capim-dourado.",
                   missionObjective: "Fotografe o lobo sem assustá-lo",
                   posX: 350.0, posY: 158.0),
        
        MissionPin(biomeId: 1, animalName: "Tamanduá-bandeira",
                   missionTitle: "O jardineiro do cerrado",
                   missionDescription: "O tamanduá cava cupinzeiros e fertiliza o solo.",
                   missionObjective: "Fotografe o tamanduá se alimentando",
                   posX: 262.0, posY: 285.0),

            
        // AMAZÔNIA (biomeId: 2)
        MissionPin(biomeId: 2, animalName: "Boto-cor-de-rosa",
                   missionTitle: "A lenda do rio",
                   missionDescription: "O boto aparece no rio quando o sol se põe.",
                   missionObjective: "Fotografe o boto na superfície",
                   posX: 180.0, posY: 130.0),
        
        MissionPin(biomeId: 2, animalName: "Arara-vermelha",
                   missionTitle: "O desenho do céu",
                   missionDescription: "As araras voam em dupla pela copa densa.",
                   missionObjective: "Fotografe a arara voando",
                   posX: 248.0, posY: 180.0),

        
        // PAMPA (biomeId: 3)
        MissionPin(biomeId: 3, animalName: "Quero-quero",
                   missionTitle: "O sentinela dos campos",
                   missionDescription: "O quero-quero avisa todo mundo quando alguém chega.",
                   missionObjective: "Fotografe o quero-quero no chão",
                   posX: 237.0, posY: 405.0),
        
        MissionPin(biomeId: 3, animalName: "Veado-campeiro",
                   missionTitle: "O corredor do pampa",
                   missionDescription: "O veado corre livre entre os campos abertos.",
                   missionObjective: "Fotografe o veado em movimento",
                   posX: 260.0, posY: 460.0),

        
        // MATA ATLÂNTICA (biomeId: 4)
        MissionPin( biomeId: 4, animalName: "Mico-leão-dourado",
                   missionTitle: "O tesouro da floresta",
                   missionDescription: "O mico vive só nas copas da Mata Atlântica.",
                   missionObjective: "Fotografe o mico na árvore",
                   posX: 342.0, posY: 280.0),
        
        MissionPin( biomeId: 4, animalName: "Gralha-azul",
                   missionTitle: "A plantadora de araucárias",
                   missionDescription: "A gralha enterra pinhões e planta novas árvores.",
                   missionObjective: "Fotografe a gralha perto da araucária",
                   posX: 350.0, posY: 346.0),

        
        // CAATINGA (biomeId: 5)
        MissionPin( biomeId: 5, animalName: "Tatu-bola",
                   missionTitle: "O campeão da defesa",
                   missionDescription: "O tatu-bola se enrola numa bola perfeita.",
                   missionObjective: "Fotografe o tatu enrolado",
                   posX: 408.0, posY: 177.0),
        
        MissionPin(biomeId: 5, animalName: "Arara-azul-de-lear",
                   missionTitle: "A joia da caatinga",
                   missionDescription: "Essa arara só existe na caatinga brasileira.",
                   missionObjective: "Fotografe a arara azul",
                   posX: 436.0, posY: 203.0),

        
        // PANTANAL (biomeId: 6)
        MissionPin(biomeId: 6, animalName: "Onça-pintada",
                   missionTitle: "A rainha do pantanal",
                   missionDescription: "A onça é a maior felina das Américas.",
                   missionObjective: "Fotografe a onça à beira do rio",
                   posX: 200.0, posY: 296.0),
        
        MissionPin(biomeId: 6, animalName: "Arara-azul",
                   missionTitle: "O gigante azul",
                   missionDescription: "A maior arara do mundo vive no pantanal.",
                   missionObjective: "Fotografe a arara no buriti",
                   posX: 228.0, posY: 322.0)
    ]
}
