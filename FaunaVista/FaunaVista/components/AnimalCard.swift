//
//  AnimalCard.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 01/10/26.
//
//
//  AnimalCard.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 01/10/26.
//

import SwiftUI

struct AnimalCard: View {

    let animal: Animal

    var body: some View {
        VStack(spacing: 0) {

            Text(animal.discovered ? animal.commonName : "Animal não descoberto")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(height: 52)
                .padding(.horizontal, 8)
                .padding(.top, 16)

            Spacer(minLength: 8)

            animalIllustration

            Spacer(minLength: 8)

            Text(biomeName)
                .font(.system(size: 16))
                .foregroundStyle(biomeTextColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 7)
                .background {
                    Capsule()
                        .fill(biomeColor)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
        }
        .frame(height: 260)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("CardBackground"))
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
    }

    // MARK: - Bioma (id Int → nome e cores)

    /// Converte o id do bioma no nome, usando a sua MapPiece
    private var biomeName: String {
        MapPiece.todosOsBiomas
            .first { $0.id == animal.biome }?.name ?? "Bioma"
    }

    private var biomeColor: Color {
        switch animal.biome {
        case 2:  return Color("AmazonColor")
        case 1:  return Color("CerradoColor")
        case 5:  return Color("CaatingaColor")
        case 4:  return Color("AtlanticForestColor")
        case 6:  return Color("PantanalColor")
        case 3:  return Color("PampaColor")
        default: return .gray
        }
    }

    private var biomeTextColor: Color {
        switch animal.biome {
        case 2, 6, 5: return .white   
        default:      return .black
        }
    }

    private var animalIllustration: some View {
        ZStack {
            Image(illustrationName)
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 90)
        }
    }

    private var illustrationName: String {
        IllustrationAnimal.imageName(
            for: animal.scientificName,
            discovered: animal.discovered
        )
    }
}
