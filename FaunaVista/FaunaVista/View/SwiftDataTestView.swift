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

        var body: some View {
            VStack(spacing: 8) {

                Text("SwiftData Test")
                    .font(.title)

                Text("Saved animals: \(animals.count)")

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

                            Text("Image URL:")
                                .font(.caption)
                                .fontWeight(.bold)

                            Text(animal.imageURL ?? "No image URL")
                                .font(.caption)
                                .textSelection(.enabled)
                            
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
    }


#Preview {
    SwiftDataTestView()
        .modelContainer(for: [
            Animal.self,
            Expedition.self,
            ExpeditionPhotoModel.self
        ])
}
