//
//  ExpeditionFinishedView.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine


// ============================================================
// MARK: - RESULTADO
// ============================================================

struct ExpeditionFinishedView: View {
    @ObservedObject var vm: ExpeditionViewModel

    let columns = [
        GridItem(
            .adaptive(minimum: 150),
            spacing: 12
        )
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Text("Expedição encerrada")
                    .font(.largeTitle.bold())

                Text("\(vm.photosTaken) fotos registradas")
                    .font(.title3)
                    .foregroundStyle(.secondary)

                ScrollView {
                    LazyVGrid(
                        columns: columns,
                        spacing: 12
                    ) {
                        ForEach(vm.photoCards) { card in
                            VStack(alignment: .leading, spacing: 6) {
                                Image(uiImage: card.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 150)
                                    .clipped()
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 12)
                                    )

                                if card.isScorable {
                                    if card.stars > 0 {
                                        Text(String(repeating: "⭐️", count: card.stars))
                                            .font(.title3)
                                    } else {
                                        Text("Sem objeto detectado")
                                            .font(.headline)
                                    }
                                } else {
                                    Text("Obstrução — sem avaliação")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                Text(card.objectName)
                                    .font(.headline)
                                if let distance = card.distance {
                                    Text(
                                        String(format: "Distância: %.2f m", distance)
                                    )
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                }
                            }
                            .padding(8)
                            .background(
                                .thinMaterial,
                                in: RoundedRectangle(cornerRadius: 16)
                            )
                            .padding(8)
                            .background(
                                .thinMaterial,
                                in: RoundedRectangle(cornerRadius: 16)
                            )
                        }
                    }
                    .padding()
                }

                Button {
                    vm.returnToStart()
                } label: {
                    Text("Novo Expedition")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(
                            Color.accentColor,
                            in: Capsule()
                        )
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
    }
}
