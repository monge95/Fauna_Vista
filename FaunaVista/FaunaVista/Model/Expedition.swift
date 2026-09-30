//
//  Expedition.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 30/09/26.
//

import Foundation
import SwiftData

@Model
final class Expedition {

    var id: UUID

    var biome: String

    var animal: Animal

    var overallRating: Int

    var challenge1Completed: Bool
    var challenge2Completed: Bool
    var challenge3Completed: Bool

    @Relationship(deleteRule: .cascade)
    var photos: [ExpeditionPhoto]

    init(
        biome: String,
        animal: Animal,
        overallRating: Int,
        challenge1Completed: Bool,
        challenge2Completed: Bool,
        challenge3Completed: Bool,
        photos: [ExpeditionPhoto] = []
    ) {
        self.id = UUID()
        self.biome = biome
        self.animal = animal
        self.overallRating = overallRating
        self.challenge1Completed = challenge1Completed
        self.challenge2Completed = challenge2Completed
        self.challenge3Completed = challenge3Completed
        self.photos = photos
    }
}
