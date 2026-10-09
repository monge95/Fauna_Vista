//
//  AnimalScenario.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 07/10/26.
//

import Foundation

struct animalScenario: Identifiable {
    let id: Int
    let assetName: String
    let BackgroundName: String
    let size: CGFloat
    let posY: CGFloat

}

struct AnimalScenario {

    static func constructCard(for scientificName: String) -> animalScenario? {
        switch scientificName {
            
        case "Myrmecophaga tridactyla":
            let animal = animalScenario(id: 1, assetName: "tamandua-bandeira",BackgroundName: "TamanduaArara", size: 100.1, posY: 100.1)
            return animal
            
        case "Chrysocyon brachyurus":
            let animal = animalScenario(id: 1,assetName: "lobo-guara" ,BackgroundName: "OncaLoboTatu", size: 100.1, posY: 100.1)
            return animal
            
        case "Inia geoffrensis":
            let animal = animalScenario(id: 1,assetName: "boto-cor-de-rosa" ,BackgroundName: "Agua", size: 100.1, posY: 100.1)
            return animal
            
        case "Cacajao rubicundus":
            let animal = animalScenario(id: 1,assetName: "uacari-vermelho" ,BackgroundName: "Uacari", size: 100.1, posY: 100.1)
            return animal
            
        case "Anodorhynchus leari":
            let animal = animalScenario(id: 1,assetName: "arara-azul" ,BackgroundName: "TamanduaArara", size: 100.1, posY: 100.1)
            return animal
            
        case "Tolypeutes tricinctus":
            let animal = animalScenario(id: 1,assetName: "tatu-bola" ,BackgroundName: "OncaLoboTatu", size: 100.1, posY: 100.1)
            return animal
            
        case "Leontopithecus rosalia":
            let animal = animalScenario(id: 1,assetName: "mico-leao-dourado" ,BackgroundName: "MicoPreguica", size: 100.1, posY: 100.1)
            return animal
            
        case "Bradypus torquatus":
            let animal = animalScenario(id: 1,assetName: "preguica-de-coleira" ,BackgroundName: "MicoPreguica", size: 100.1, posY: 100.1)
            return animal
            
        case "Pteronura brasiliensis":
            let animal = animalScenario(id: 1,assetName: "ariranha" ,BackgroundName: "Agua", size: 100.1, posY: 100.1)
            return animal
            
        case "Panthera onca":
            let animal = animalScenario(id: 1,assetName: "onca-pintada" ,BackgroundName: "OncaLoboTatu", size: 100.1, posY: 100.1)
            return animal
            
        case "Xanthopsar flavus":
            let animal = animalScenario(id: 1,assetName: "onca-pintada" ,BackgroundName: "OncaLoboTatu", size: 100.1, posY: 100.1)
            return animal
            
        case "Ceratophrys ornata":
            let animal = animalScenario(id: 1,assetName: "onca-pintada" ,BackgroundName: "OncaLoboTatu", size: 100.1, posY: 100.1)
            return animal
            
        default:
            return nil
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
