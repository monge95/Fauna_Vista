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
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemGray4))
                    .frame(width: 150, height: 160)
                animalIllustration
            }
            Spacer(minLength: 8)

            Text(animal.biome)
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
        .frame(height: 300)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("CardBackground"))
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
    }

    private var animalIllustration: some View {
        ZStack {

            Image(illustrationName)
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 90)
                

            if !animal.discovered {
                Text("?")
                    .font(.system(size: 65, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
    }

    private var illustrationName: String {
        IllustrationAnimal.imageName(
            for: animal.scientificName,
            discovered: animal.discovered
        )
    }


    private var biomeColor: Color {
        switch animal.biome {

        case "Amazônia":
            return Color("AmazonColor")

        case "Cerrado":
            return Color("CerradoColor")

        case "Caatinga":
            return Color("CaatingaColor")

        case "Mata Atlântica":
            return Color("AtlanticForestColor")

        case "Pantanal":
            return Color("PantanalColor")

        case "Pampa":
            return Color("PampaColor")

        default:
            return .gray
        }
    }

    private var biomeTextColor: Color {
        switch animal.biome {

        case "Amazônia", "Pantanal", "Caatinga":
            return .white

        default:
            return .black
        }
    }
}
