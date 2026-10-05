//
//  ExpeditionPhoto.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 30/09/26.
//

import Foundation
import SwiftData

@Model
final class ExpeditionPhotoModel{

    var id: UUID

    var image: Data?

    var rating: Int

    init(
        image: Data? = nil,
        rating: Int
    ) {
        self.id = UUID()
        self.image = image
        self.rating = rating
    }
}

