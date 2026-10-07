//
//  MissionPin.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 02/10/26.
//

import SwiftUI

struct MissionPin: Identifiable {

    let id: UUID = UUID()
    let biomeId: Int

    let animalName: String
    let scientificName: String
    let assetsName: String
    let assetsNameDiscovered: String
    
    let missionObjective1: String
    let missionObjective2: String
    let missionObjective3: String

    let posX: CGFloat
    let posY: CGFloat
    
    static let allMissionPins: [MissionPin] = [

        // CERRADO

        MissionPin(
            biomeId: 1,
            animalName: "Lobo-guará",
            scientificName: "Chrysocyon brachyurus",
            assetsName: "PinLobo",
            assetsNameDiscovered: "pinLoboDiscovered",
            missionObjective1: "Fotografe o animal parado",
            missionObjective2: "Fotografe o animal em movimento",
            missionObjective3: "Fotografe o animal dormindo",
            posX: 350.0,
            posY: 158.0
        ),

        MissionPin(
            biomeId: 1,
            animalName: "Tamanduá-bandeira",
            scientificName: "Myrmecophaga tridactyla",
            assetsName: "PinTamandua",
            assetsNameDiscovered: "pinTamanduaDiscovered",
            missionObjective1: "Fotografe o animal parado",
            missionObjective2: "Fotografe o animal em movimento",
            missionObjective3: "Fotografe o animal se alimentando",
            posX: 262.0,
            posY: 285.0
        ),


        // AMAZÔNIA

        MissionPin(
            biomeId: 2,
            animalName: "Boto-cor-de-rosa",
            scientificName: "Inia geoffrensis",
            assetsName: "PinBoto",
            assetsNameDiscovered: "PinBotodiscovered",
            missionObjective1: "Fotografe o animal parado",
            missionObjective2: "Fotografe o animal em movimento",
            missionObjective3: "Fotografe o animal subindo à superfície para respirar",
            posX: 280.0,
            posY: 100.0
        ),

        MissionPin(
            biomeId: 2,
            animalName: "Uacari-vermelho",
            scientificName: "Cacajao rubicundus",
            assetsName: "PinUacari",
            assetsNameDiscovered: "pinUracaridiscovered",
            missionObjective1: "Fotografe o animal parado",
            missionObjective2: "Fotografe o animal em movimento",
            missionObjective3: "Fotografe o animal pendurado em um galho",
            posX: 108.0,
            posY: 140.0
        ),


        // PAMPA

        MissionPin(
            biomeId: 3,
            animalName: "Veste-amarela",
            scientificName: "Xanthopsar flavus",
            assetsName: "PinVeste",
            assetsNameDiscovered: "pinVesteDiscovered",
            missionObjective1: "Fotografe o animal parado",
            missionObjective2: "Fotografe o animal em movimento",
            missionObjective3: "Fotografe o animal voando",
            posX: 237.0,
            posY: 405.0
        ),

        MissionPin(
            biomeId: 3,
            animalName: "Sapo-de-chifres",
            scientificName: "Ceratophrys ornata",
            assetsName: "PinSapo",
            assetsNameDiscovered: "pinSapoDiscovered",
            missionObjective1: "Fotografe o animal parado",
            missionObjective2: "Fotografe o animal em movimento",
            missionObjective3: "Fotografe o animal capturando um inseto com a língua",
            posX: 260.0,
            posY: 460.0
        ),


        // MATA ATLÂNTICA

        MissionPin(
            biomeId: 4,
            animalName: "Mico-leão-dourado",
            scientificName: "Leontopithecus rosalia",
            assetsName: "PinMico",
            assetsNameDiscovered: "pinMicoDiscovered",
            missionObjective1: "Fotografe o animal parado",
            missionObjective2: "Fotografe o animal em movimento",
            missionObjective3: "Fotografe o animal capturando um inseto na árvore",
            posX: 392.0,
            posY: 280.0
        ),

        MissionPin(
            biomeId: 4,
            animalName: "Preguiça-de-coleira",
            scientificName: "Bradypus torquatus",
            assetsName: "PinPreguiça",
            assetsNameDiscovered: "pinPreguiçaDiscovered",
            missionObjective1: "Fotografe o animal parado",
            missionObjective2: "Fotografe o animal em movimento",
            missionObjective3: "Fotografe o animal descendo da árvore",
            posX: 280.0,
            posY: 380.0
        ),


        // CAATINGA

        MissionPin(
            biomeId: 5,
            animalName: "Tatu-bola",
            scientificName: "Tolypeutes tricinctus",
            assetsName: "PinTatu",
            assetsNameDiscovered: "pinTatuDiscovered",
            missionObjective1: "Fotografe o animal parado",
            missionObjective2: "Fotografe o animal em movimento",
            missionObjective3: "Fotografe o animal se enrolando em uma bola",
            posX: 400.0,
            posY: 210.0
        ),

        MissionPin(
            biomeId: 5,
            animalName: "Arara-azul-de-lear",
            scientificName: "Anodorhynchus leari",
            assetsName: "PinArara",
            assetsNameDiscovered: "pinAraraDiscovered",
            missionObjective1: "Fotografe o animal parado",
            missionObjective2: "Fotografe o animal em movimento",
            missionObjective3: "Fotografe o animal se alimentando em uma árvore",
            posX: 410.0,
            posY: 150.0
        ),


        // PANTANAL

        MissionPin(
            biomeId: 6,
            animalName: "Onça-pintada",
            scientificName: "Panthera onca",
            assetsName: "PinOnça",
            assetsNameDiscovered: "pinOnçaDiscovered",
            missionObjective1: "Fotografe o animal parado",
            missionObjective2: "Fotografe o animal em movimento",
            missionObjective3: "Fotografe o animal entrando na água",
            posX: 225.0,
            posY: 260.0
        ),

        MissionPin(
            biomeId: 6,
            animalName: "Ariranha",
            scientificName: "Pteronura brasiliensis",
            assetsName: "PinAriranha",
            assetsNameDiscovered: "pinAriranhaDiscovered",
            missionObjective1: "Fotografe o animal parado",
            missionObjective2: "Fotografe o animal em movimento",
            missionObjective3: "Fotografe o animal saindo da água",
            posX: 205.0,
            posY: 310.0
        )
    ]
}
