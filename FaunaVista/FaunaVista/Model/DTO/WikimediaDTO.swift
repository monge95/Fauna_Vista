
//
//  WikimediaDTO.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 29/09/26.
//

import Foundation

struct WikimediaResponse: Decodable {
    let query: WikimediaQuery?
}

struct WikimediaQuery: Decodable {
    let pages: [String: WikimediaPage]
}

struct WikimediaPage: Decodable {
    let pageid: Int
    let title: String
    let imageinfo: [WikimediaImageInfo]?
}

struct WikimediaImageInfo: Decodable {
    let url: String
    let descriptionurl: String
    let thumburl: String?
    let extmetadata: WikimediaMetadata?
}

struct WikimediaMetadata: Decodable {
    let Artist: WikimediaMetadataValue?
    let LicenseShortName: WikimediaMetadataValue?
    let LicenseUrl: WikimediaMetadataValue?
}

struct WikimediaMetadataValue: Decodable {
    let value: String
}
