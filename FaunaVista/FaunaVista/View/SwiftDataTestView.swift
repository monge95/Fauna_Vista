//
//  SwiftDataTestView.swift
//  
//
//  Created by Gabriel Groppo on 28/09/26.
//

import SwiftUI
import SwiftData

struct SwiftDataTestView: View {

    @Environment(\.modelContext) private var modelContext
    @Query private var animais: [Animal]

    var body: some View {
        VStack(spacing: 8) {

            Text("Teste SwiftData")
                .font(.title)

            Text("Animais salvos: \(animais.count)")

            List {
                ForEach(animais) { animal in
                    VStack(alignment: .leading, spacing: 8) {

                        GeometryReader { geometry in
                            AsyncImage(
                                url: URL(string: animal.imagemURL ?? "")
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
                                        .scaledToFill()
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

                        Text(animal.nomePopular)
                            .font(.headline)

                        Text(animal.nomeCientifico)

                        Text("Bioma: \(animal.localizacao)")

                        Text(
                            "Status: \(animal.statusConservacao)"
                        )

                        Text(
                            "Descoberto: \(animal.descoberto ? "Sim" : "Não")"
                        )

                        Text(
                            "Autor: \(animal.imagemAutor ?? "Não informado")"
                        )
                        .font(.caption)

                        Text(
                            "Licença: \(animal.imagemLicenca ?? "Não informada")"
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
                    .inicializarCatalogoSeNecessario()

            } catch {
                print(
                    "Erro ao inicializar catálogo: \(error)"
                )
            }
        }
    }
}

#Preview {
    SwiftDataTestView()
        .modelContainer(for: Animal.self)
}
