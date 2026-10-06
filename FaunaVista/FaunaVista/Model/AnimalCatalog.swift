//
//  AnimalCatalog.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 28/09/26.
//

import Foundation

struct AnimalCatalog {
    let scientificName: String
    let biome: Int
    let wikimediaPageID: Int
    let commonName: String?
    let conservationStatus: String?

    init(
        scientificName: String,
        biome: Int,
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
        biome: 2,
        wikimediaPageID: 1458187
    ),

    AnimalCatalog(
        scientificName: "Cacajao rubicundus",
        biome: 2,
        wikimediaPageID: 1257420,
        commonName: "Uacari-vermelho",
        conservationStatus: "least concern"
    ),

    // CERRADO
    AnimalCatalog(
        scientificName: "Chrysocyon brachyurus",
        biome: 1,
        wikimediaPageID: 33061605
    ),

    AnimalCatalog(
        scientificName: "Myrmecophaga tridactyla",
        biome: 1,
        wikimediaPageID: 112286751
    ),

    // CAATINGA
    AnimalCatalog(
        scientificName: "Anodorhynchus leari",
        biome: 5,
        wikimediaPageID: 180012045
    ),

    AnimalCatalog(
        scientificName: "Tolypeutes tricinctus",
        biome: 5,
        wikimediaPageID: 165855470
    ),

    // ATLANTIC FOREST
    AnimalCatalog(
        scientificName: "Leontopithecus rosalia",
        biome: 4,
        wikimediaPageID: 127755134
    ),

    AnimalCatalog(
        scientificName: "Bradypus torquatus",
        biome: 4,
        wikimediaPageID: 195086874
    ),

    // PANTANAL
    AnimalCatalog(
        scientificName: "Pteronura brasiliensis",
        biome: 6,
        wikimediaPageID: 60637166
    ),

    AnimalCatalog(
        scientificName: "Panthera onca",
        biome: 6,
        wikimediaPageID: 44247575,
        commonName: "Onça-pintada"
    ),

    // PAMPA
    AnimalCatalog(
        scientificName: "Xanthopsar flavus",
        biome: 3,
        wikimediaPageID: 20154213
    ),

    AnimalCatalog(
        scientificName: "Ceratophrys ornata",
        biome: 3,
        wikimediaPageID: 3376971
    )
]
