//
//  AnimalCatalogo.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 28/09/26.
//

import Foundation

struct AnimalCatalogo {
    let nomeCientifico: String
    let localizacao: String
    let wikimediaPageID: Int
    let nomePopular: String?
    let statusConservacao: String?

    init(
        nomeCientifico: String,
        localizacao: String,
        wikimediaPageID: Int,
        nomePopular: String? = nil,
        statusConservacao: String? = nil
    ) {
        self.nomeCientifico = nomeCientifico
        self.localizacao = localizacao
        self.wikimediaPageID = wikimediaPageID
        self.nomePopular = nomePopular
        self.statusConservacao = statusConservacao
    }
}
let catalogoAnimais: [AnimalCatalogo] = [

    // AMAZÔNIA
    AnimalCatalogo(
        nomeCientifico: "Inia geoffrensis",
        localizacao: "Amazônia",
        wikimediaPageID: 1458187
    ),

    AnimalCatalogo(
        nomeCientifico: "Cacajao rubicundus",
        localizacao: "Amazônia",
        wikimediaPageID: 1257420,
        nomePopular: "Uacari-vermelho",
        statusConservacao: "least concern"
        
    ),

    // CERRADO
    AnimalCatalogo(
        nomeCientifico: "Chrysocyon brachyurus",
        localizacao: "Cerrado",
        wikimediaPageID: 33061605
    ),

    AnimalCatalogo(
        nomeCientifico: "Myrmecophaga tridactyla",
        localizacao: "Cerrado",
        wikimediaPageID: 112286751
    ),

    // CAATINGA
    AnimalCatalogo(
        nomeCientifico: "Anodorhynchus leari",
        localizacao: "Caatinga",
        wikimediaPageID: 180012045
    ),

    AnimalCatalogo(
        nomeCientifico: "Tolypeutes tricinctus",
        localizacao: "Caatinga",
        wikimediaPageID: 165855470
    ),

    // MATA ATLÂNTICA
    AnimalCatalogo(
        nomeCientifico: "Leontopithecus rosalia",
        localizacao: "Mata Atlântica",
        wikimediaPageID: 127755134
    ),

    AnimalCatalogo(
        nomeCientifico: "Bradypus torquatus",
        localizacao: "Mata Atlântica",
        wikimediaPageID: 195086874
    ),

    // PANTANAL
    AnimalCatalogo(
        nomeCientifico: "Pteronura brasiliensis",
        localizacao: "Pantanal",
        wikimediaPageID: 60637166
    ),

    AnimalCatalogo(
        nomeCientifico: "Panthera onca",
        localizacao: "Pantanal",
        wikimediaPageID: 44247575,
        nomePopular: "Onça-pintada"
    ),

    // PAMPA
    AnimalCatalogo(
        nomeCientifico: "Xanthopsar flavus",
        localizacao: "Pampa",
        wikimediaPageID: 20154213
    ),

    AnimalCatalogo(
        nomeCientifico: "Ceratophrys ornata",
        localizacao: "Pampa",
        wikimediaPageID: 3376971
    )
]
