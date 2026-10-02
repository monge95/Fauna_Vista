//
//  ExpeditionImageRegisteredView.swift
//  FaunaVista
//
//  Created by Felipe Colares Cardoso on 02/10/26.
//

//
//  ExpeditionAnimalRegisteredView.swift
//

import SwiftUI

struct ExpeditionAnimalRegisteredView: View {
    let animalName: String
    let scientificName: String
    let biome: String
    let onViewCollection: () -> Void

    var body: some View {
        ZStack {
            FaunaPalette.tealLight.ignoresSafeArea()

            VStack(spacing: 14) {
                Text("ANIMAL REGISTRADO")
                    .font(.system(size: 11, weight: .semibold))
                    .tracking(1)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(Color.black.opacity(0.08), in: Capsule())

                Text(animalName)
                    .font(.system(size: 28, weight: .heavy))
                    .multilineTextAlignment(.center)

                Text(scientificName)
                    .font(.footnote.italic())
                    .foregroundStyle(.secondary)

                Image(IllustrationAnimal.imageName(for: scientificName, discovered: true))
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)

                Label(biome, systemImage: "mappin")
                    .font(.system(size: 17, weight: .medium))

                Button(action: onViewCollection) {
                    Text("Ver na coleção")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(FaunaPalette.teal, in: Capsule())
                }
                .padding(.top, 8)
            }
            .foregroundStyle(.black)
            .padding(24)
            .background(FaunaPalette.beige, in: RoundedRectangle(cornerRadius: 32))
            .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
            .padding(.horizontal, 28)
        }
    }
}
