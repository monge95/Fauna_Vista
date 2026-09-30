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

    func carregarCatalogo() async throws {

        for animalCatalogo in catalogoAnimais {

            if let taxon = try await iNaturalistService.buscarAnimal(
                nomeCientifico: animalCatalogo.nomeCientifico
            ) {

                let paginaWikimedia = try await wikimediaService.buscarImagem(
                    pageID: animalCatalogo.wikimediaPageID
                )

                let imagemWikimedia = paginaWikimedia?.imageinfo?.first

                let imagemURL =
                    imagemWikimedia?.thumburl
                    ?? imagemWikimedia?.url

                let imagemFonteURL =
                    imagemWikimedia?.descriptionurl

                let imagemAutor = wikimediaService.limparAutor(
                    imagemWikimedia?.extmetadata?.Artist?.value
                )

                let imagemLicenca =
                    imagemWikimedia?.extmetadata?.LicenseShortName?.value

                let imagemLicencaURL =
                    imagemWikimedia?.extmetadata?.LicenseUrl?.value

                try repository.salvarTaxon(
                    taxon,
                    localizacao: animalCatalogo.localizacao,
                    nomePopular: animalCatalogo.nomePopular,
                    statusConservacao: animalCatalogo.statusConservacao,
                    imagemURL: imagemURL,
                    imagemFonteURL: imagemFonteURL,
                    imagemAutor: imagemAutor,
                    imagemLicenca: imagemLicenca,
                    imagemLicencaURL: imagemLicencaURL
                )

            } else {
                print(
                    "Animal não encontrado: \(animalCatalogo.nomeCientifico)"
                )
            }
        }
    }

    func inicializarCatalogoSeNecessario() async throws {

        let quantidade = try repository.quantidadeDeAnimais()

        guard quantidade < catalogoAnimais.count else {
            print("Catálogo já inicializado.")
            return
        }

        print(
            "Catálogo incompleto: \(quantidade)/\(catalogoAnimais.count)"
        )

        try await carregarCatalogo()

        print("Catálogo inicializado.")
    }
}
