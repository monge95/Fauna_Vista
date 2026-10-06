//
//  MissionAnimalIdentification.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 05/10/26.
//

import SwiftUI

struct MissionAnimalIdentification: View {

    let scientificName: String

    var body: some View {
        VStack(spacing: 12) {

            Image(illustrationName)
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 140)
                .padding(16)
                .background {
                    Circle()
                        .fill(.gray.opacity(0.15))
                }

            Text("Animal não identificado")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.black)
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background {
                    Capsule()
                        .fill(.gray.opacity(0.2))
                }
        }
    }

    private var illustrationName: String {
        IllustrationAnimal.imageName(
            for: scientificName,
            discovered: false
        )
    }
}
