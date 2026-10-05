//
//  collection.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 28/09/26.
//

import SwiftUI
import SwiftData

struct CollectionView: View {
    @Environment(AppCordinator.self) private var coordinator
    @Query private var animals: [Animal]

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
   

    var body: some View {
        
        
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Text("Coleção de animais")
                        .font(.custom("Belanosima-SemiBold", size: 32))
                        .foregroundStyle(.black)

                    Spacer()

                    Button(action: {
                        coordinator.push(.information)
                    }) {
                        Image(systemName: "info")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 20, height: 20)
                    }
                    .frame(width: 44, height: 44)
                    .buttonStyle(.plain)
                    .background {
                        Circle()
                            .fill(.ultraThinMaterial)
                    }
                    .overlay {
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        .white.opacity(0.8),
                                        .clear,
                                        .white.opacity(0.2)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.5
                            )
                    }
                    .shadow(
                        color: .black.opacity(0.15),
                        radius: 4,
                        x: 2,
                        y: 4
                    )
                }

                LazyVGrid(
                    columns: columns,
                    spacing: 12
                ) {
                    ForEach(orderedAnimals) { animal in

                        if animal.discovered {
                            NavigationLink {
                                AnimalDetailView(animal: animal)
                            } label: {
                                AnimalCard(animal: animal)
                            }
                            .buttonStyle(.plain)

                        } else {
                            AnimalCard(animal: animal)
                        }
                    }
                }
                
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 40)
        }
        .background(
            Color("CollectionBackground")
                .ignoresSafeArea()
        )
    }
    
    private var orderedAnimals: [Animal] {
        let order: [String: Int] = [
            "Inia geoffrensis": 0,
            "Cacajao rubicundus": 1,
            "Chrysocyon brachyurus": 2,
            "Myrmecophaga tridactyla": 3,
            "Anodorhynchus leari": 4,
            "Tolypeutes tricinctus": 5,
            "Leontopithecus rosalia": 6,
            "Bradypus torquatus": 7,
            "Pteronura brasiliensis": 8,
            "Panthera onca": 9,
            "Xanthopsar flavus": 10,
            "Ceratophrys ornata": 11
        ]

        
        return animals.sorted {
            order[$0.scientificName, default: Int.max]
                < order[$1.scientificName, default: Int.max]
        }
    }
}

#Preview {
    CollectionView()
        .modelContainer(PreviewSupport.container)
        .environment(PreviewSupport.coordinator)
}
