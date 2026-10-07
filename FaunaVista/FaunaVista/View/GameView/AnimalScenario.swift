//
//  AnimalScenario.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 07/10/26.
//

import Foundation

struct AnimalScenario {

    static func backgroundName(for scientificName: String) -> String {
        switch scientificName {

        case "Myrmecophaga tridactyla":
            return "TamanduaArara"

        case "Chrysocyon brachyurus":
            return "OncaLoboTatu"

        case "Inia geoffrensis":
            return "Agua"

        case "Cacajao rubicundus":
            return "Uacari"

        case "Anodorhynchus leari":
            return "TamanduaArara"

        case "Tolypeutes tricinctus":
            return "OncaLoboTatu"

        case "Leontopithecus rosalia":
            return "MicoPreguica"

        case "Bradypus torquatus":
            return "MicoPreguica"

        case "Pteronura brasiliensis":
            return "Agua"

        case "Panthera onca":
            return "OncaLoboTatu"

        case "Xanthopsar flavus":
            return "Veste"

        case "Ceratophrys ornata":
            return "Agua"

        default:
            return ""
        }
    }

    static func groundName(for scientificName: String) -> String {
        switch scientificName {

        case "Myrmecophaga tridactyla":
            return "Terra"

        case "Chrysocyon brachyurus":
            return "Terra"

        case "Inia geoffrensis":
            return "chao-boto"

        case "Cacajao rubicundus":
            return "Terra"

        case "Anodorhynchus leari":
            return "Galho"

        case "Tolypeutes tricinctus":
            return "Terra"

        case "Leontopithecus rosalia":
            return "Grama"

        case "Bradypus torquatus":
            return "chao-preguica"

        case "Pteronura brasiliensis":
            return "chao-ariranha"

        case "Panthera onca":
            return "Terra"

        case "Xanthopsar flavus":
            return "Galho"

        case "Ceratophrys ornata":
            return "Aguachao"

        default:
            return ""
        }
    }
}
