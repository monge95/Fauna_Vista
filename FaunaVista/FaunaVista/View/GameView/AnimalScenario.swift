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
            let animal = animalScenario(id: 1, assetName: "tamanduaChao",BackgroundName: "TamanduaArara", size: 260.1, posY: 5.1)
            return animal
            
        case "Chrysocyon brachyurus":
            let animal = animalScenario(id: 1,assetName: "loboChao" ,BackgroundName: "OncaLoboTatu", size: 260.1, posY: 2.1)
            return animal
            
        case "Inia geoffrensis":
            let animal = animalScenario(id: 1,assetName: "boto-cor-de-rosa" ,BackgroundName: "Agua", size: 260.1, posY: 10.1)
            return animal
            
        case "Cacajao rubicundus":
            let animal = animalScenario(id: 1,assetName: "uacariChao" ,BackgroundName: "Uacari", size: 260.1, posY: 10.1)
            return animal
            
        case "Anodorhynchus leari":
            let animal = animalScenario(id: 1,assetName: "araraChao" ,BackgroundName: "TamanduaArara", size: 260.1, posY: -50.1)
            return animal
            
        case "Tolypeutes tricinctus":
            let animal = animalScenario(id: 1,assetName: "tatuChao" ,BackgroundName: "OncaLoboTatu", size: 260.1, posY: 30.1)
            return animal
            
        case "Leontopithecus rosalia":
            let animal = animalScenario(id: 1,assetName: "micoChao" ,BackgroundName: "MicoPreguica", size: 270.00, posY: 45)
            return animal
                    
        case "Bradypus torquatus":
            let animal = animalScenario(id: 1,assetName: "preguica-de-coleira" ,BackgroundName: "MicoPreguica", size: 270, posY: 0)
            return animal
                    
        case "Pteronura brasiliensis":
            let animal = animalScenario(id: 1,assetName: "ariranha" ,BackgroundName: "Agua", size: 300, posY: 5)
            return animal
                
        case "Panthera onca":
            let animal = animalScenario(id: 1,assetName: "oncaChao" ,BackgroundName: "OncaLoboTatu", size: 300, posY: 5)
            return animal

        case "Xanthopsar flavus":
            let animal = animalScenario(id: 1,assetName: "vesteChao" ,BackgroundName: "Veste", size: 256.72, posY: 20)
            return animal

            
        case "Ceratophrys ornata":
            let animal = animalScenario(id: 1,assetName: "sapoChao" ,BackgroundName: "Agua", size: 260.0, posY: 5)
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
