//
//  ExpeditionLevel.swift
//  FaunaVista
//
//  Created by Felipe Colares Cardoso on 04/10/26.
//
import SwiftUI
import Foundation

struct ExpeditionLevel: Identifiable {
    let id: String
    let scientificName: String   // liga ao MissionPin e ao Animal do SwiftData
    let animalID: String         // id em ExpeditionAnimalConfig (ex.: "animal_1")
    let mapFileName: String      // .usdz do mapa (sem extensão)

    // Modelos usados nos slots Vegetacao_N do Blender.
    var grassModel = "gramaCerrado"
    var treeModel = "arvorecerrado1"
    // Quais Vegetacao_N são árvore; os demais usam grassModel.
    var treeSlots: Set<Int> = [2, 6, 11, 15]

    var animal: ExpeditionAnimalDefinition? {
        ExpeditionAnimalConfig.animals.first { $0.id == animalID }
    }

    var vegetationModelNames: [String] { [grassModel, treeModel] }

    static let all: [ExpeditionLevel] = [
        // CERRADO
        ExpeditionLevel(id: "cerrado1", scientificName: "Myrmecophaga tridactyla",
                        animalID: "animal_1", mapFileName: "MapaCerrado"),
        ExpeditionLevel(id: "cerrado2", scientificName: "Chrysocyon brachyurus",
                        animalID: "animal_2", mapFileName: "MapaCerrado2"),

        // AMAZÔNIA  (troque grassModel/treeModel quando tiver os modelos)
        ExpeditionLevel(id: "amazonia1", scientificName: "Inia geoffrensis",
                        animalID: "animal_3", mapFileName: "MapaAmazonia"),
        ExpeditionLevel(id: "amazonia2", scientificName: "Cacajao rubicundus",
                        animalID: "animal_4", mapFileName: "MapaAmazonia2"),

        // PAMPA
        ExpeditionLevel(id: "pampa1", scientificName: "Xanthopsar flavus",
                        animalID: "animal_5", mapFileName: "MapaPampa"),
        ExpeditionLevel(id: "pampa2", scientificName: "Ceratophrys ornata",
                        animalID: "animal_6", mapFileName: "MapaPampa2"),

        // MATA ATLÂNTICA
        ExpeditionLevel(id: "mata1", scientificName: "Leontopithecus rosalia",
                        animalID: "animal_7", mapFileName: "MapaMataAtlantica"),
        ExpeditionLevel(id: "mata2", scientificName: "Bradypus torquatus",
                        animalID: "animal_8", mapFileName: "MapaMataAtlantica2"),

        // CAATINGA
        ExpeditionLevel(id: "caatinga1", scientificName: "Anodorhynchus leari",
                        animalID: "animal_9", mapFileName: "MapaCaatinga"),
        ExpeditionLevel(id: "caatinga2", scientificName: "Tolypeutes tricinctus",
                        animalID: "animal_10", mapFileName: "MapaCaatinga2"),

        // PANTANAL
        ExpeditionLevel(id: "pantanal1", scientificName: "Pteronura brasiliensis",
                        animalID: "animal_11", mapFileName: "MapaPantanal"),
        ExpeditionLevel(id: "pantanal2", scientificName: "Panthera onca",
                        animalID: "animal_12", mapFileName: "MapaPantanal2"),
    ]

    static func level(for scientificName: String?) -> ExpeditionLevel? {
        guard let scientificName else { return nil }
        return all.first { $0.scientificName == scientificName }
    }
}
