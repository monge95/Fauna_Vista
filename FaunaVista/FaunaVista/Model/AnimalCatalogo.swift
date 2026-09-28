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
    let nomePopular: String?
    let statusConservacao: String?

    init(
        nomeCientifico: String,
        localizacao: String,
        nomePopular: String? = nil,
        statusConservacao: String? = nil
    ) {
        self.nomeCientifico = nomeCientifico
        self.localizacao = localizacao
        self.nomePopular = nomePopular
        self.statusConservacao = statusConservacao
    }
}
let catalogoAnimais: [AnimalCatalogo] = [

    // AMAZÔNIA
    AnimalCatalogo(
        nomeCientifico: "Inia geoffrensis",
        localizacao: "Amazônia"
    ),

    AnimalCatalogo(
        nomeCientifico: "Cacajao rubicundus",
        localizacao: "Amazônia",
        nomePopular: "Uacari-vermelho",
        statusConservacao: "least concern"
    ),

    // CERRADO
    AnimalCatalogo(
        nomeCientifico: "Chrysocyon brachyurus",
        localizacao: "Cerrado"
    ),

    AnimalCatalogo(
        nomeCientifico: "Myrmecophaga tridactyla",
        localizacao: "Cerrado"
    ),

    // CAATINGA
    AnimalCatalogo(
        nomeCientifico: "Anodorhynchus leari",
        localizacao: "Caatinga"
    ),

    AnimalCatalogo(
        nomeCientifico: "Tolypeutes tricinctus",
        localizacao: "Caatinga"
    ),

    // MATA ATLÂNTICA
    AnimalCatalogo(
        nomeCientifico: "Leontopithecus rosalia",
        localizacao: "Mata Atlântica"
    ),

    AnimalCatalogo(
        nomeCientifico: "Bradypus torquatus",
        localizacao: "Mata Atlântica"
    ),

    // PANTANAL
    AnimalCatalogo(
        nomeCientifico: "Pteronura brasiliensis",
        localizacao: "Pantanal"
    ),

    AnimalCatalogo(
        nomeCientifico: "Panthera onca",
        localizacao: "Pantanal",
        nomePopular: "Onça-pintada"
    ),

    // PAMPA
    AnimalCatalogo(
        nomeCientifico: "Xanthopsar flavus",
        localizacao: "Pampa"
    ),

    AnimalCatalogo(
        nomeCientifico: "Ceratophrys ornata",
        localizacao: "Pampa"
    )
]
