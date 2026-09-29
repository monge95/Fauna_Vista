//
//  Animal.swift
//  
//
//  Created by Gabriel Groppo on 28/09/26.
//

import Foundation
import SwiftData

@Model
final class Animal {
    var id: UUID

    @Attribute(.unique)
    var taxonID: Int

    var nomePopular: String
    var nomeCientifico: String
    var localizacao: String
    var statusConservacao: String

    var imagemURL: String?
    var imagemFonteURL: String?
    var imagemAutor: String?
    var imagemLicenca: String?
    var imagemLicencaURL: String?

    var descoberto: Bool

    init(
        taxonID: Int,
        nomePopular: String,
        nomeCientifico: String,
        localizacao: String,
        statusConservacao: String,
        imagemURL: String? = nil,
        imagemFonteURL: String? = nil,
        imagemAutor: String? = nil,
        imagemLicenca: String? = nil,
        imagemLicencaURL: String? = nil,
        descoberto: Bool = false
    ) {
        self.id = UUID()
        self.taxonID = taxonID
        self.nomePopular = nomePopular
        self.nomeCientifico = nomeCientifico
        self.localizacao = localizacao
        self.statusConservacao = statusConservacao

        self.imagemURL = imagemURL
        self.imagemFonteURL = imagemFonteURL
        self.imagemAutor = imagemAutor
        self.imagemLicenca = imagemLicenca
        self.imagemLicencaURL = imagemLicencaURL

        self.descoberto = descoberto
    }
}
