//
//  AnimalBasicInfoCard.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 02/10/26.
//

import SwiftUI

struct AnimalBasicInfoCard: View {

    let animal: Animal

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            VStack(alignment: .leading, spacing: 4) {
                Text("Nome científico")
                    .font(.system(size: 18, weight: .bold))

                Text(animal.scientificName)
                    .font(.system(size: 16))
                    .italic()
            }

            HStack(alignment: .top, spacing: 12) {

                VStack(alignment: .leading, spacing: 6) {
                    Text("Bioma")
                        .font(.system(size: 18, weight: .bold))

                    AnimalTag(
                        text: animal.biome,
                        backgroundColor: biomeColor,
                        textColor: biomeTextColor
                    )
                }

                Spacer()

                VStack(alignment: .leading, spacing: 6) {
                    Text("Grau de ameaça")
                        .font(.system(size: 18, weight: .bold))

                    AnimalTag(
                        text: animal.conservationStatus,
                        backgroundColor: conservationStatusColor
                    )
                }
            }
        }
        .foregroundStyle(.black)
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.white))
        }
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
        case "Amazônia", "Mata Atlântica":
            return .white

        default:
            return .black
        }
    }

    private var conservationStatusColor: Color {
        switch animal.conservationStatus.lowercased() {

        case "vulnerable", "vulnerável":
            return .yellow.opacity(0.7)

        case "endangered", "em perigo":
            return .orange.opacity(0.7)

        case "critically endangered", "criticamente em perigo":
            return .red.opacity(0.7)

        case "near threatened", "quase ameaçado":
            return .yellow.opacity(0.4)

        case "least concern", "pouco preocupante":
            return .green.opacity(0.5)

        default:
            return .gray.opacity(0.4)
        }
    }
}
