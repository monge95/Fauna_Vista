//
//  INaturalistService.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 28/09/26.
//

import Foundation

final class INaturalistService {
    
    func buscarAnimal(
        nomeCientifico: String
    ) async throws -> INaturalistTaxon? {
        
        var components = URLComponents(
            string: "https://api.inaturalist.org/v1/taxa"
        )!
        
        components.queryItems = [
            URLQueryItem(
                name: "q",
                value: nomeCientifico
            ),
            URLQueryItem(
                name: "locale",
                value: "pt-BR"
            )
        ]
        
        let url = components.url!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let resposta = try decoder.decode(
            INaturalistResponse.self,
            from: data
        )
        
        return resposta.results.first { taxon in
            taxon.name.lowercased() == nomeCientifico.lowercased()
            && taxon.rank == "species"
        }
    }
}
