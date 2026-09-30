//
//  AnimalRepository.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 29/09/26.
//

import Foundation
import SwiftData

final class AnimalRepository {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func salvarTaxon(
        _ taxon: INaturalistTaxon,
        localizacao: String,
        nomePopular: String? = nil,
        statusConservacao: String? = nil,
        imagemURL: String? = nil,
        imagemFonteURL: String? = nil,
        imagemAutor: String? = nil,
        imagemLicenca: String? = nil,
        imagemLicencaURL: String? = nil
    ) throws {
        
        let taxonID = taxon.id
        
        let nomeFinal =
            nomePopular
            ?? taxon.preferredCommonName
            ?? "Nome não informado"
        
        let statusFinal =
            statusConservacao
            ?? taxon.conservationStatus?.statusName
            ?? "Não informado"
        
        if let animalExistente = try buscarPorTaxonID(taxonID) {
            
            animalExistente.nomePopular = nomeFinal
            animalExistente.nomeCientifico = taxon.name
            animalExistente.localizacao = localizacao
            animalExistente.statusConservacao = statusFinal
            
            animalExistente.imagemURL = imagemURL
            animalExistente.imagemFonteURL = imagemFonteURL
            animalExistente.imagemAutor = imagemAutor
            animalExistente.imagemLicenca = imagemLicenca
            animalExistente.imagemLicencaURL = imagemLicencaURL
            
            print("Animal atualizado: \(nomeFinal)")
            
        } else {
            
            let novoAnimal = Animal(
                taxonID: taxon.id,
                nomePopular: nomeFinal,
                nomeCientifico: taxon.name,
                localizacao: localizacao,
                statusConservacao: statusFinal,
                imagemURL: imagemURL,
                imagemFonteURL: imagemFonteURL,
                imagemAutor: imagemAutor,
                imagemLicenca: imagemLicenca,
                imagemLicencaURL: imagemLicencaURL
            )
            
            modelContext.insert(novoAnimal)
            
            print("Animal criado: \(nomeFinal)")
        }
        
        try modelContext.save()
    }
    
    func marcarComoDescoberto(taxonID: Int) throws {
        
        guard let animal = try buscarPorTaxonID(taxonID) else {
            print("Animal não encontrado.")
            return
        }
        
        animal.descoberto = true
        
        try modelContext.save()
        
        print("Animal descoberto: \(animal.nomePopular)")
    }
    
    func buscarPorTaxonID(_ taxonID: Int) throws -> Animal? {
        
        var descriptor = FetchDescriptor<Animal>(
            predicate: #Predicate { animal in
                animal.taxonID == taxonID
            }
        )
        
        descriptor.fetchLimit = 1
        
        return try modelContext.fetch(descriptor).first
    }
    
    func quantidadeDeAnimais() throws -> Int {
        let descriptor = FetchDescriptor<Animal>()
        
        return try modelContext.fetchCount(descriptor)
    }
    
    func buscarPorBioma(_ bioma: String) throws -> [Animal] {
        
        let descriptor = FetchDescriptor<Animal>(
            predicate: #Predicate { animal in
                animal.localizacao == bioma
            }
        )
        
        return try modelContext.fetch(descriptor)
    }
    
    func buscarDescobertos() throws -> [Animal] {
        
        let descriptor = FetchDescriptor<Animal>(
            predicate: #Predicate { animal in
                animal.descoberto == true
            }
        )
        
        return try modelContext.fetch(descriptor)
    }
}

