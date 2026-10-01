//
//  collection.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 28/09/26.
//

import SwiftUI
import SwiftData

struct CollectionView: View {

    @Query private var animals: [Animal]

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                Text("Coleção de animais")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(.black)

                LazyVGrid(
                    columns: columns,
                    spacing: 12
                ) {
                    ForEach(animals) { animal in
                        AnimalCard(animal: animal)
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
}

#Preview {
    CollectionView()
        .modelContainer(PreviewSupport.container)
}
