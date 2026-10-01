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

    func saveTaxon(
        _ taxon: INaturalistTaxon,
        biome: String,
        commonName: String? = nil,
        conservationStatus: String? = nil,
        imageURL: String? = nil,
        imageSourceURL: String? = nil,
        imageAuthor: String? = nil,
        imageLicense: String? = nil,
        imageLicenseURL: String? = nil
    ) throws {

        let taxonID = taxon.id

        let finalName =
            commonName
            ?? taxon.preferredCommonName
            ?? "Nome não informado"

        let finalStatus =
            conservationStatus
            ?? taxon.conservationStatus?.statusName
            ?? "Não informado"

        if let existingAnimal = try findByTaxonID(taxonID) {

            existingAnimal.commonName = finalName
            existingAnimal.scientificName = taxon.name
            existingAnimal.biome = biome
            existingAnimal.conservationStatus = finalStatus

            existingAnimal.imageURL = imageURL
            existingAnimal.imageSourceURL = imageSourceURL
            existingAnimal.imageAuthor = imageAuthor
            existingAnimal.imageLicense = imageLicense
            existingAnimal.imageLicenseURL = imageLicenseURL

            print("Animal updated: \(finalName)")

        } else {

            let newAnimal = Animal(
                taxonID: taxon.id,
                commonName: finalName,
                scientificName: taxon.name,
                biome: biome,
                conservationStatus: finalStatus,
                imageURL: imageURL,
                imageSourceURL: imageSourceURL,
                imageAuthor: imageAuthor,
                imageLicense: imageLicense,
                imageLicenseURL: imageLicenseURL
            )

            modelContext.insert(newAnimal)

            print("Animal created: \(finalName)")
        }

        try modelContext.save()
    }

    func markAsDiscovered(taxonID: Int) throws {

        guard let animal = try findByTaxonID(taxonID) else {
            print("Animal not found.")
            return
        }

        animal.discovered = true

        try modelContext.save()

        print("Animal discovered: \(animal.commonName)")
    }

    func findByTaxonID(_ taxonID: Int) throws -> Animal? {

        var descriptor = FetchDescriptor<Animal>(
            predicate: #Predicate { animal in
                animal.taxonID == taxonID
            }
        )

        descriptor.fetchLimit = 1

        return try modelContext.fetch(descriptor).first
    }

    func animalCount() throws -> Int {
        let descriptor = FetchDescriptor<Animal>()

        return try modelContext.fetchCount(descriptor)
    }

    func findByBiome(_ biome: String) throws -> [Animal] {

        let descriptor = FetchDescriptor<Animal>(
            predicate: #Predicate { animal in
                animal.biome == biome
            }
        )

        return try modelContext.fetch(descriptor)
    }

    func findDiscovered() throws -> [Animal] {

        let descriptor = FetchDescriptor<Animal>(
            predicate: #Predicate { animal in
                animal.discovered == true
            }
        )

        return try modelContext.fetch(descriptor)
    }
}
