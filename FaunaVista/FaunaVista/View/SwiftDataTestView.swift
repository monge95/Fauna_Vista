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
                
                Button {
                    createTestExpedition()
                } label: {
                    Text("Criar expedição teste - Tamanduá")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("buttonColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)

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
        private func createTestExpedition() {

            let scientificName = "Myrmecophaga tridactyla"

            guard let animal = animals.first(where: {
                $0.scientificName == scientificName
            }) else {
                print("❌ Tamanduá não encontrado")
                return
            }

            let photos = [
                ExpeditionPhotoModel(
                    image: nil,
                    rating: 0
                ),
                ExpeditionPhotoModel(
                    image: nil,
                    rating: 0
                ),
                ExpeditionPhotoModel(
                    image: nil,
                    rating: 0
                )
            ]

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
                    challenge2Completed: true,
                    challenge3Completed: false,
                    photos: photos
                )

                print("✅ Expedição teste criada para \(animal.commonName)")

            } catch ExpeditionServiceError.expeditionAlreadyExists {

                print("⚠️ Já existe uma expedição para \(animal.commonName)")

            } catch {

                print("❌ Erro ao criar expedição teste: \(error)")
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
