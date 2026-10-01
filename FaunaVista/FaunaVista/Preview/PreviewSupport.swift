//
//  PreviewSupport.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 01/10/26.
//
import SwiftData

enum PreviewSupport {

    @MainActor
    static var container: ModelContainer {
        do {
            let configuration = ModelConfiguration(
                isStoredInMemoryOnly: true
            )

            let container = try ModelContainer(
                for:
                    Animal.self,
                    Expedition.self,
                    ExpeditionPhotoModel.self,
                configurations: configuration
            )

            for animal in animals {
                container.mainContext.insert(animal)
            }

            return container

        } catch {
            fatalError(
                "Failed to create preview ModelContainer: \(error)"
            )
        }
    }

    @MainActor
    static var expeditionLog: ExpeditionLog {
        ExpeditionLog()
    }

    @MainActor
    static var coordinator: AppCordinator {
        AppCordinator()
    }

    static var animals: [Animal] {
        [
            // Amazônia
            Animal(
                taxonID: 1,
                commonName: "Boto-cor-de-rosa",
                scientificName: "Inia geoffrensis",
                biome: "Amazônia",
                conservationStatus: "Em perigo",
                discovered: true
            ),

            Animal(
                taxonID: 2,
                commonName: "Uacari-vermelho",
                scientificName: "Cacajao rubicundus",
                biome: "Amazônia",
                conservationStatus: "Pouco preocupante",
                discovered: true
            ),

            // Cerrado
            Animal(
                taxonID: 3,
                commonName: "Lobo-guará",
                scientificName: "Chrysocyon brachyurus",
                biome: "Cerrado",
                conservationStatus: "Quase ameaçado",
                discovered: true
            ),

            Animal(
                taxonID: 47107,
                commonName: "Tamanduá-bandeira",
                scientificName: "Myrmecophaga tridactyla",
                biome: "Cerrado",
                conservationStatus: "Vulnerável",
                discovered: true
            ),

            // Caatinga
            Animal(
                taxonID: 5,
                commonName: "Arara-azul",
                scientificName: "Anodorhynchus leari",
                biome: "Caatinga",
                conservationStatus: "Em perigo",
                discovered: true
            ),

            Animal(
                taxonID: 6,
                commonName: "Tatu-bola",
                scientificName: "Tolypeutes tricinctus",
                biome: "Caatinga",
                conservationStatus: "Vulnerável",
                discovered: true
            ),

            // Mata Atlântica
            Animal(
                taxonID: 7,
                commonName: "Mico-leão-dourado",
                scientificName: "Leontopithecus rosalia",
                biome: "Mata Atlântica",
                conservationStatus: "Em perigo",
                discovered: true
            ),

            Animal(
                taxonID: 8,
                commonName: "Preguiça-de-coleira",
                scientificName: "Bradypus torquatus",
                biome: "Mata Atlântica",
                conservationStatus: "Vulnerável",
                discovered: true
            ),

            // Pantanal
            Animal(
                taxonID: 9,
                commonName: "Ariranha",
                scientificName: "Pteronura brasiliensis",
                biome: "Pantanal",
                conservationStatus: "Em perigo",
                discovered: true
            ),

            Animal(
                taxonID: 10,
                commonName: "Onça-pintada",
                scientificName: "Panthera onca",
                biome: "Pantanal",
                conservationStatus: "Quase ameaçado",
                discovered: true
            ),

            // Pampa
            Animal(
                taxonID: 11,
                commonName: "Veste-amarela",
                scientificName: "Xanthopsar flavus",
                biome: "Pampa",
                conservationStatus: "Vulnerável",
                discovered: true
            ),

            Animal(
                taxonID: 12,
                commonName: "Sapo-de-chifres",
                scientificName: "Ceratophrys ornata",
                biome: "Pampa",
                conservationStatus: "Vulnerável",
                discovered: true
            )
        ]
    }
}
