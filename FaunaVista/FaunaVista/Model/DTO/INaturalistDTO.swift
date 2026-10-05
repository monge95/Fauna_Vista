//
//  INaturalistDTO.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 28/09/26.
//

import Foundation

struct INaturalistResponse: Decodable {
    let totalResults: Int
    let results: [INaturalistTaxon]
}

struct INaturalistTaxon: Decodable {
    let id: Int
    let rank: String
    let name: String
    let preferredCommonName: String?
    let conservationStatus: ConservationStatus?
}

struct ConservationStatus: Decodable {
    let status: String
    let statusName: String
}
