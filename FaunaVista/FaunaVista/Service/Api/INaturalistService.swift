//
//  INaturalistService.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 28/09/26.
//

import Foundation

final class INaturalistService {

    func fetchAnimal(
        scientificName: String
    ) async throws -> INaturalistTaxon? {

        guard var components = URLComponents(
            string: "https://api.inaturalist.org/v1/taxa"
        ) else {
            throw URLError(.badURL)
        }

        components.queryItems = [
            URLQueryItem(
                name: "q",
                value: scientificName
            ),
            URLQueryItem(
                name: "locale",
                value: "pt-BR"
            )
        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(
            from: url
        )

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let result = try decoder.decode(
            INaturalistResponse.self,
            from: data
        )

        return result.results.first { taxon in
            taxon.name.lowercased() == scientificName.lowercased()
            && taxon.rank == "species"
        }
    }
}
