//
//  Animal.swift
//  FaunaVista
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

    var commonName: String
    var scientificName: String
    var biome: Int
    var conservationStatus: String

    var imageURL: String?
    var imageSourceURL: String?
    var imageAuthor: String?
    var imageLicense: String?
    var imageLicenseURL: String?

    var discovered: Bool

    init(
        taxonID: Int,
        commonName: String,
        scientificName: String,
        biome: Int,
        conservationStatus: String,
        imageURL: String? = nil,
        imageSourceURL: String? = nil,
        imageAuthor: String? = nil,
        imageLicense: String? = nil,
        imageLicenseURL: String? = nil,
        discovered: Bool = false
    ) {
        self.id = UUID()
        self.taxonID = taxonID
        self.commonName = commonName
        self.scientificName = scientificName
        self.biome = biome
        self.conservationStatus = conservationStatus

        self.imageURL = imageURL
        self.imageSourceURL = imageSourceURL
        self.imageAuthor = imageAuthor
        self.imageLicense = imageLicense
        self.imageLicenseURL = imageLicenseURL

        self.discovered = discovered
    }
}
