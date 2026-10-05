//
//  ExpeditionStartView.swift
//

import SwiftUI

// MARK: - TELA INICIAL (com as missões)
struct ExpeditionStartView: View {
    @ObservedObject var vm: ExpeditionViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 22) {
                Image(systemName: "binoculars.fill")
                    .font(.system(size: 60))

                Text("Fauna Vista")
                    .font(.largeTitle.bold())

                Text("Encontre \(vm.missionAnimal?.displayName ?? "o animal") e registre seus comportamentos com a câmera.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)

                VStack(alignment: .leading, spacing: 14) {
                    Text("Missões")
                        .font(.headline)

                    ForEach(ExpeditionMission.allCases) { mission in
                        HStack(alignment: .top, spacing: 12) {
                            Text("\(mission.rawValue + 1)")
                                .font(.subheadline.bold())
                                .foregroundStyle(.white)
                                .frame(width: 28, height: 28)
                                .background(FaunaPalette.teal, in: Circle())

                            Text(mission.title)
                                .font(.subheadline)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))

                VStack(spacing: 6) {
                    Text("Fotos: \(ExpeditionConfig.totalPhotos)")
                    Text("Tempo: \(Int(ExpeditionConfig.gameDuration)) s")
                    Text("Depois você escolhe \(ExpeditionConfig.photosToSubmit) fotos para análise.")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Button {
                    vm.startGame()
                } label: {
                    Text("Começar Expedição")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(FaunaPalette.teal, in: Capsule())
                }
            }
            .padding()
        }
    }
}
#Preview {
    ExpeditionStartView(vm: ExpeditionViewModel())
}
