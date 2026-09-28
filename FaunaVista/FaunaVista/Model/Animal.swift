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
    @Attribute(.unique) var taxonID: Int
    var nomePopular: String
    var nomeCientifico: String
    var localizacao: String
    var statusConservacao: String
    var imagemURL: String?
    
    init(
        taxonID: Int,
        nomePopular: String,
        nomeCientifico: String,
        localizacao: String,
        statusConservacao: String,
        imagemURL: String? = nil
    ) {
        self.id = UUID()
        self.taxonID = taxonID
        self.nomePopular = nomePopular
        self.nomeCientifico = nomeCientifico
        self.localizacao = localizacao
        self.statusConservacao = statusConservacao
        self.imagemURL = imagemURL
    }
}
