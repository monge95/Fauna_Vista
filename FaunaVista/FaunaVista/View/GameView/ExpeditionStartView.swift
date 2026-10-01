//
//  ExpeditionStartView.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine


// MARK: - TELA INICIAL
struct ExpeditionStartView: View {
    @ObservedObject var vm: ExpeditionViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 22) {
                    Image(systemName: "binoculars.fill")
                        .font(.system(size: 60))

                    Text("Fauna Vista")
                        .font(.largeTitle.bold())

                    Text(
                        "Explore a fauna brasileira, encontre animais pouco conhecidos e registre seus encontros."
                    )
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Detecção por mira")
                            .font(.headline)

                        Text("Aponte o ponto central para o objeto 3D e tire a foto dentro da distância válida.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        ForEach(ExpeditionObjectType.allCases.filter { $0.category == .vegetation }) { object in
                            HStack {
                                Image(systemName: "cube.fill")
                                Text(object.displayName)
                                Spacer()
                                Text(object.modelName + ".usdz")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .padding()
                    .background(
                        .thinMaterial,
                        in: RoundedRectangle(cornerRadius: 20)
                    )

                    VStack(spacing: 6) {
                        if vm.mapLoaded {
                            Text("Percurso: \(Int(vm.travelDistance)) m")
                            Text("Tempo: \(Int(vm.travelDuration)) s")
                        } else {
                            Text("Mapa: FaunaVistaMap.usdz")
                            Text("O percurso será calculado pelo mapa.")
                        }

                        Text("Fotos: \(ExpeditionConfig.totalPhotos)")
                        Text("Distância válida: \(String(format: "%.1f", ExpeditionConfig.minimumCaptureDistance))–\(String(format: "%.1f", ExpeditionConfig.maxCaptureDistance)) m")
                    }
                    .foregroundStyle(.secondary)

                    Button {
                        vm.startGame()
                    } label: {
                        Text("Começar Expedição")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                Color.accentColor,
                                in: Capsule()
                            )
                    }
                }
                .padding()
            }
            .navigationTitle("Fauna Vista")
        }
    }
}
