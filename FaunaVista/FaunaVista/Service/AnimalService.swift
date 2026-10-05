//
//  AnimalService.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 29/09/26.
//

import Foundation

final class AnimalService {

    private let repository: AnimalRepository
    private let iNaturalistService: INaturalistService
    private let wikimediaService: WikimediaService

    init(
        repository: AnimalRepository,
        iNaturalistService: INaturalistService = INaturalistService(),
        wikimediaService: WikimediaService = WikimediaService()
    ) {
        self.repository = repository
        self.iNaturalistService = iNaturalistService
        self.wikimediaService = wikimediaService
    }

    func loadCatalog() async throws {

        for catalogAnimal in animalCatalog {

            if let taxon = try await iNaturalistService.fetchAnimal(
                scientificName: catalogAnimal.scientificName
            ) {

                let wikimediaPage = try await wikimediaService.fetchImage(
                    pageID: catalogAnimal.wikimediaPageID
                )

                let wikimediaImage = wikimediaPage?.imageinfo?.first

                let imageURL =
                    wikimediaImage?.thumburl
                    ?? wikimediaImage?.url

                let imageSourceURL =
                    wikimediaImage?.descriptionurl

                let imageAuthor = wikimediaService.cleanAuthor(
                    wikimediaImage?.extmetadata?.Artist?.value
                )

                let imageLicense =
                    wikimediaImage?.extmetadata?.LicenseShortName?.value

                let imageLicenseURL =
                    wikimediaImage?.extmetadata?.LicenseUrl?.value

                try repository.saveTaxon(
                    taxon,
                    biome: catalogAnimal.biome,
                    commonName: catalogAnimal.commonName,
                    conservationStatus: catalogAnimal.conservationStatus,
                    imageURL: imageURL,
                    imageSourceURL: imageSourceURL,
                    imageAuthor: imageAuthor,
                    imageLicense: imageLicense,
                    imageLicenseURL: imageLicenseURL
                )

            } else {
                print(
                    "Animal not found: \(catalogAnimal.scientificName)"
                )
            }
        }
    }

    func initializeCatalogIfNeeded() async throws {

        let count = try repository.animalCount()

        guard count < animalCatalog.count else {
            print("Catalog already initialized.")
            return
        }

        print(
            "Incomplete catalog: \(count)/\(animalCatalog.count)"
        )

        try await loadCatalog()

        print("Catalog initialized.")
    }
}
