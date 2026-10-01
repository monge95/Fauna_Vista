//
//  ExpeditionService.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 30/09/26.
//


import Foundation

final class ExpeditionService {

    private let repository: ExpeditionRepository

    init(repository: ExpeditionRepository) {
        self.repository = repository
    }
    
    
    func finishExpedition(
        biome: String,
        animal: Animal,
        challenge1Completed: Bool,
        challenge2Completed: Bool,
        challenge3Completed: Bool,
        photos: [ExpeditionPhoto]
    ) throws {

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
}
