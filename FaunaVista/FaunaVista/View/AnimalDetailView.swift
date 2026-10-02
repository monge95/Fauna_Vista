//
//  AnimalDetailView.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 01/10/26.
//

import SwiftUI

struct AnimalDetailView: View {

    let animal: Animal

    private var information: AnimalInformation? {
        AnimalInformationData.information[animal.scientificName]
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                AnimalDetailHeader(
                    title: animal.commonName
                )

                AnimalDetailImage(
                    animal: animal
                )

                AnimalBasicInfoCard(
                    animal: animal
                )

                if let information {
                    AnimalInformationCard(
                        information: information
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 40)
        }
        .background(
            Color("BeigeBackground")
                .ignoresSafeArea()
        )
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AnimalDetailView(
        animal: Animal(
            taxonID: 47107,
            commonName: "Tamanduá-bandeira",
            scientificName: "Myrmecophaga tridactyla",
            biome: "Cerrado",
            conservationStatus: "Vulnerável",
            imageURL:"https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f6/Myrmecophaga_tridactyla_86003248.jpg/1280px-Myrmecophaga_tridactyla_86003248.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail",
            discovered: true
        )
    )
}
