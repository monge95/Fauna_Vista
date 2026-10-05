//
//  ExpeditionRepository.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 30/09/26.
//

import Foundation
import SwiftData

enum ExpeditionRepositoryError: Error {
    case invalidPhotoCount
}

final class ExpeditionRepository {

    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func createExpedition(_ expedition: Expedition) throws {

        guard expedition.photos.count == 3 else {
            throw ExpeditionRepositoryError.invalidPhotoCount
        }

        modelContext.insert(expedition)

        try modelContext.save()

        print("Expedition created for: \(expedition.animal.commonName)")
    }
    
    func findByAnimal(_ animal: Animal) throws -> Expedition? {

        let animalID = animal.id

        var descriptor = FetchDescriptor<Expedition>(
            predicate: #Predicate { expedition in
                expedition.animal.id == animalID
            }
        )

        descriptor.fetchLimit = 1

        return try modelContext.fetch(descriptor).first
    }
    
    func findByBiome(_ biome: Int) throws -> [Expedition] {

        let descriptor = FetchDescriptor<Expedition>(
            predicate: #Predicate { expedition in
                expedition.biome == biome
            }
        )

        return try modelContext.fetch(descriptor)
    }
    func deleteExpedition(_ expedition: Expedition) throws {

        modelContext.delete(expedition)

        try modelContext.save()

        print("Expedition deleted for: \(expedition.animal.commonName)")
    }
}
