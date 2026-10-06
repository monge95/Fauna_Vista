//
//  CompletedMissionAnimalIdentification.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 06/10/26.
//

import SwiftUI

struct CompletedMissionAnimalIdentification: View {

    let animal: Animal

    var body: some View {
        VStack(spacing: 6) {

            Image(
                IllustrationAnimal.imageName(
                    for: animal.scientificName,
                    discovered: true
                )
            )
            .resizable()
            .scaledToFit()
            .frame(width: 115, height: 115)

            Text(animal.commonName)
                .font(.system(size: 22, weight: .bold))

            Text(animal.scientificName)
                .font(.system(size: 16))
                .italic()
        }
    }
}
