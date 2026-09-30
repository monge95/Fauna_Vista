//
//  AnimalCatalog.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 28/09/26.
//

import Foundation

struct AnimalCatalog {
    let scientificName: String
    let biome: String
    let wikimediaPageID: Int
    let commonName: String?
    let conservationStatus: String?

    init(
        scientificName: String,
        biome: String,
        wikimediaPageID: Int,
        commonName: String? = nil,
        conservationStatus: String? = nil
    ) {
        self.scientificName = scientificName
        self.biome = biome
        self.wikimediaPageID = wikimediaPageID
        self.commonName = commonName
        self.conservationStatus = conservationStatus
    }
}

let animalCatalog: [AnimalCatalog] = [

    // AMAZON
    AnimalCatalog(
        scientificName: "Inia geoffrensis",
        biome: "Amazônia",
        wikimediaPageID: 1458187
    ),

    AnimalCatalog(
        scientificName: "Cacajao rubicundus",
        biome: "Amazônia",
        wikimediaPageID: 1257420,
        commonName: "Uacari-vermelho",
        conservationStatus: "least concern"
    ),

    // CERRADO
    AnimalCatalog(
        scientificName: "Chrysocyon brachyurus",
        biome: "Cerrado",
        wikimediaPageID: 33061605
    ),

    AnimalCatalog(
        scientificName: "Myrmecophaga tridactyla",
        biome: "Cerrado",
        wikimediaPageID: 112286751
    ),

    // CAATINGA
    AnimalCatalog(
        scientificName: "Anodorhynchus leari",
        biome: "Caatinga",
        wikimediaPageID: 180012045
    ),

    AnimalCatalog(
        scientificName: "Tolypeutes tricinctus",
        biome: "Caatinga",
        wikimediaPageID: 165855470
    ),

    // ATLANTIC FOREST
    AnimalCatalog(
        scientificName: "Leontopithecus rosalia",
        biome: "Mata Atlântica",
        wikimediaPageID: 127755134
    ),

    AnimalCatalog(
        scientificName: "Bradypus torquatus",
        biome: "Mata Atlântica",
        wikimediaPageID: 195086874
    ),

    // PANTANAL
    AnimalCatalog(
        scientificName: "Pteronura brasiliensis",
        biome: "Pantanal",
        wikimediaPageID: 60637166
    ),

    AnimalCatalog(
        scientificName: "Panthera onca",
        biome: "Pantanal",
        wikimediaPageID: 44247575,
        commonName: "Onça-pintada"
    ),

    // PAMPA
    AnimalCatalog(
        scientificName: "Xanthopsar flavus",
        biome: "Pampa",
        wikimediaPageID: 20154213
    ),

    AnimalCatalog(
        scientificName: "Ceratophrys ornata",
        biome: "Pampa",
        wikimediaPageID: 3376971
    )
]
