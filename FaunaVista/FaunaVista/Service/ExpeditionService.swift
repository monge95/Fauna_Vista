//
//  ExpeditionService.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 30/09/26.
//


import Foundation

enum ExpeditionServiceError: Error {
    case expeditionAlreadyExists
}

final class ExpeditionService {

    private let repository: ExpeditionRepository

    init(repository: ExpeditionRepository) {
        self.repository = repository
    }
    
    
    
    func finishExpedition(
        biome: Int,
        animal: Animal,
        challenge1Completed: Bool,
        challenge2Completed: Bool,
        challenge3Completed: Bool,
        photos: [ExpeditionPhotoModel]
    ) throws {

        if try repository.findByAnimal(animal) != nil {
            throw ExpeditionServiceError.expeditionAlreadyExists
        }
        
        let overallRating = [
            challenge1Completed,
            challenge2Completed,
            challenge3Completed
        ].filter { $0 }.count

        let expedition = Expedition(
            biome: biome,
            animal: animal,
            overallRating: overallRating,
            challenge1Completed: challenge1Completed,
            challenge2Completed: challenge2Completed,
            challenge3Completed: challenge3Completed,
            photos: photos
        )

        try repository.createExpedition(expedition)
    }
    
    func redoExpedition(for animal: Animal) throws {

        guard let expedition = try repository.findByAnimal(animal) else {
            return
        }

        try repository.deleteExpedition(expedition)
    }
}
