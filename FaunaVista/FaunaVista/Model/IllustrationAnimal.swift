//
//  IllustrationAnimal.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 01/10/26.
//

import Foundation

struct IllustrationAnimal {

    static func imageName(
        for scientificName: String,
        discovered: Bool
    ) -> String {

        let baseName: String

        switch scientificName {

        case "Inia geoffrensis":
            baseName = "boto-cor-de-rosa"

        case "Cacajao rubicundus":
            baseName = "uacari-vermelho"

        case "Chrysocyon brachyurus":
            baseName = "lobo-guara"

        case "Myrmecophaga tridactyla":
            baseName = "tamandua-bandeira"

        case "Anodorhynchus leari":
            baseName = "arara-azul"

        case "Tolypeutes tricinctus":
            baseName = "tatu-bola"

        case "Leontopithecus rosalia":
            baseName = "mico-leao-dourado"

        case "Bradypus torquatus":
            baseName = "preguica-de-coleira"

        case "Pteronura brasiliensis":
            baseName = "ariranha"

        case "Panthera onca":
            baseName = "onca-pintada"

        case "Xanthopsar flavus":
            baseName = "veste-amarela"

        case "Ceratophrys ornata":
            baseName = "sapo-de-chifres"

        default:
            return "animal-placeholder"
        }

        return discovered
            ? baseName
            : "\(baseName)-silhouette"
    }
}
