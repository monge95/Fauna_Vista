//
//  WikimediaService.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 29/09/26.
//

import Foundation

final class WikimediaService {

    func fetchImage(
        pageID: Int
    ) async throws -> WikimediaPage? {

        guard var components = URLComponents(
            string: "https://commons.wikimedia.org/w/api.php"
        ) else {
            throw URLError(.badURL)
        }

        components.queryItems = [
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(
                name: "pageids",
                value: String(pageID)
            ),
            URLQueryItem(
                name: "prop",
                value: "imageinfo"
            ),
            URLQueryItem(
                name: "iiprop",
                value: "url|extmetadata"
            ),
            URLQueryItem(
                name: "iiurlwidth",
                value: "1200"
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

        let result = try decoder.decode(
            WikimediaResponse.self,
            from: data
        )

        guard let pages = result.query?.pages else {
            return nil
        }

        return pages[String(pageID)]
    }

    func cleanAuthor(_ author: String?) -> String? {
        return removeHTML(author)
    }

    private func removeHTML(_ text: String?) -> String? {
        guard let text else {
            return nil
        }

        return text.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression
        )
    }
}
