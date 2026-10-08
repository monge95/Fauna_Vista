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
                        text: biomeName,
                        backgroundColor: biomeColor,
                        textColor: biomeTextColor
                    )
                }

                Spacer()

                VStack(alignment: .leading, spacing: 6) {
                    Text("Grau de extinção")
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
                .fill(.white)
        }
    }

    // MARK: - Bioma (id Int → nome e cores)

    /// Converte o id do bioma no nome, usando a sua MapPiece
    private var biomeName: String {
        MapPiece.todosOsBiomas
            .first { $0.id == animal.biome }?.name ?? "Bioma"
    }

    private var biomeColor: Color {
        switch animal.biome {
        case 2:  return Color("AmazonColor")          // Amazônia
        case 1:  return Color("CerradoColor")         // Cerrado
        case 5:  return Color("CaatingaColor")        // Caatinga
        case 4:  return Color("AtlanticForestColor")  // Mata Atlântica
        case 6:  return Color("PantanalColor")        // Pantanal
        case 3:  return Color("PampaColor")           // Pampa
        default: return .gray
        }
    }

    private var biomeTextColor: Color {
        switch animal.biome {
        case 2, 4: return .white   // Amazônia e Mata Atlântica
        default:   return .black
        }
    }


    private var conservationStatusColor: Color {
        switch animal.conservationStatus.lowercased() {

        case "pouco preocupante":
            return .green.opacity(0.5)

        case "quase ameaçado":
            return .yellow.opacity(0.4)

        case "vulnerável":
            return .yellow.opacity(0.7)

        case "em perigo":
            return .orange.opacity(0.7)

        case "criticamente em perigo":
            return .red.opacity(0.7)

        case "extinto na natureza":
            return .red.opacity(0.8)

        case "extinto":
            return .red

        case "dados insuficientes":
            return .gray.opacity(0.4)

        case "não avaliado":
            return .gray.opacity(0.4)

        default:
            return .gray.opacity(0.4)
        }
    }
}
