//
//  ExpeditionImageRegisteredView.swift
//  FaunaVista
//
//  Created by Felipe Colares Cardoso on 02/10/26.
//
// TELA "GANHOU" DO FIGMA
//
//  ExpeditionAnimalRegisteredView.swift
//
import SwiftUI

struct ExpeditionAnimalRegisteredView: View {
    let animalName: String
    let scientificName: String
    let biome: Int
    let isDiscovered: Bool 
    let onViewCollection: () -> Void
    
    private var biomeName: String {
           MapPiece.todosOsBiomas
               .first { $0.id == biome }?.name ?? "Bioma"
       }

    private var biomeColor: Color {
        switch biome {
        case 2:  return Color("AmazonColor")
        case 1:  return Color("CerradoColor")
        case 5:  return Color("CaatingaColor")
        case 4:  return Color("AtlanticForestColor")
        case 6:  return Color("PantanalColor")
        case 3:  return Color("PampaColor")
        default: return .gray
        }
    }


    var body: some View {
        ZStack {
            FaunaPalette.tealLight.ignoresSafeArea()

            VStack(spacing: 14) {
                Text(isDiscovered ? "ANIMAL REGISTRADO" : "EXPEDIÇÃO CONCLUÍDA")
                    .font(.system(size: 11, weight: .semibold))
                    .tracking(1)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(Color.black.opacity(0.08), in: Capsule())

                if isDiscovered {
                    Text(animalName)
                        .font(.system(size: 28, weight: .heavy))
                        .multilineTextAlignment(.center)

                    Text(scientificName)
                        .font(.footnote.italic())
                         .foregroundStyle(.secondary)
                }

                ZStack(alignment: .bottom) {
                    if let animal = AnimalScenario.constructCard(for: scientificName){
                        Image(animal.BackgroundName)
                            .resizable()
                            .scaledToFit()
                            
                        
                            
                            if isDiscovered {
                                Image(animal.assetName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: animal.size)
                            .position(y: animal.posY)
                            
                        } else {
                            Text("Nada foi descoberto")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundStyle(.white)
                                .padding(.bottom, 60)
                                .shadow(color: .black.opacity(0.5), radius: 2)
                        }
                    }
                }
                .frame(height: 200)

                Label(biomeName, systemImage: "mappin")
                    .font(.system(size: 17, weight: .medium))

                Button(action: onViewCollection) {
                    Text(isDiscovered ? "Ver na coleção" : "Encerrar expedição")
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
