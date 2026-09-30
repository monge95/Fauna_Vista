//
//  SwiftDataTestView.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 28/09/26.
//

import SwiftUI
import SwiftData

struct SwiftDataTestView: View {

    @Environment(\.modelContext) private var modelContext
    @Query private var animals: [Animal]
    @Query private var expeditions: [Expedition]
    @Query private var expeditionPhotos: [ExpeditionPhoto]

    var body: some View {
        VStack(spacing: 8) {

            Text("SwiftData Test")
                .font(.title)

            Text("Saved animals: \(animals.count)")
            Text("Saved expeditions: \(expeditions.count)")
            Text("Saved expedition photos: \(expeditionPhotos.count)")

            List {
                ForEach(animals) { animal in
                    VStack(alignment: .leading, spacing: 8) {

                        GeometryReader { geometry in
                            AsyncImage(
                                url: URL(string: animal.imageURL ?? "")
                            ) { phase in

                                switch phase {

                                case .empty:
                                    ProgressView()
                                        .frame(
                                            width: geometry.size.width,
                                            height: 300
                                        )

                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(
                                            width: geometry.size.width,
                                            height: 300
                                        )
                                        .clipped()

                                case .failure:
                                    Image(systemName: "photo")
                                        .frame(
                                            width: geometry.size.width,
                                            height: 300
                                        )

                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        .frame(height: 300)

                        Text(animal.commonName)
                            .font(.headline)

                        Text(animal.scientificName)

                        Text("Biome: \(animal.biome)")

                        Text(
                            "Status: \(animal.conservationStatus)"
                        )

                        Text(
                            "Discovered: \(animal.discovered ? "Yes" : "No")"
                        )

                        Text(
                            "Author: \(animal.imageAuthor ?? "Not informed")"
                        )
                        .font(.caption)

                        Text(
                            "License: \(animal.imageLicense ?? "Not informed")"
                        )
                        .font(.caption)
                    }
                }
            }
            Button("Create Test Expedition") {
                createTestExpedition()
            }
            .buttonStyle(.borderedProminent)
            .padding()
            Button("Delete Test Expedition") {
                deleteTestExpedition()
            }
            .buttonStyle(.bordered)
            .padding()
            
            ForEach(expeditions) { expedition in
                VStack(alignment: .leading) {
                    Text("Expedition: \(expedition.animal.commonName)")
                    Text("Biome: \(expedition.biome)")
                    Text("Overall rating: \(expedition.overallRating)")
                    Text("Photos: \(expedition.photos.count)")
                }
            }
        }
        .task {
            do {
                let repository = AnimalRepository(
                    modelContext: modelContext
                )

                let animalService = AnimalService(
                    repository: repository
                )

                try await animalService
                    .initializeCatalogIfNeeded()

            } catch {
                print(
                    "Error initializing catalog: \(error)"
                )
            }
        }
    }
    
    private func createTestExpedition() {

        guard let animal = animals.first else {
            print("No animal available.")
            return
        }

        let photo1 = ExpeditionPhoto(
            image: nil,
            rating: 5
        )

        let photo2 = ExpeditionPhoto(
            image: nil,
            rating: 3
        )

        let photo3 = ExpeditionPhoto(
            image: nil,
            rating: 4
        )

        let repository = ExpeditionRepository(
            modelContext: modelContext
        )

        let service = ExpeditionService(
            repository: repository
        )

        do {
            try service.finishExpedition(
                biome: animal.biome,
                animal: animal,
                challenge1Completed: true,
                challenge2Completed: false,
                challenge3Completed: true,
                photos: [
                    photo1,
                    photo2,
                    photo3
                ]
            )

        } catch {
            print(
                "Error creating expedition: \(error)"
            )
        }
    }
    
    private func deleteTestExpedition() {

        guard let expedition = expeditions.first else {
            print("No expedition available.")
            return
        }

        let repository = ExpeditionRepository(
            modelContext: modelContext
        )

        do {
            try repository.deleteExpedition(expedition)

        } catch {
            print(
                "Error deleting expedition: \(error)"
            )
        }
    }
}

#Preview {
    SwiftDataTestView()
        .modelContainer(for: [
            Animal.self,
            Expedition.self,
            ExpeditionPhoto.self
        ])
}
