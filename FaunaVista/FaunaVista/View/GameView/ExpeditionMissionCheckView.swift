//
//  ExpeditionMissionCheckView.swift
//  Missões + as 3 fotos enviadas. Checkmark verde nas cumpridas.
//  TELA "CHECK" DO FIGMA

import SwiftUI

struct ExpeditionMissionCheckView: View {
    @ObservedObject var vm: ExpeditionViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            FaunaPalette.beige.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 14) {
                    Image(IllustrationAnimal.imageName(
                        for: vm.missionAnimal?.scientificName ?? "",
                        discovered: true
                    ))
                    .resizable()
                    .scaledToFit()
                    .frame(height: 190)

                    Text(vm.missionAnimal?.displayName ?? "Animal")
                        .font(.system(size: 20, weight: .bold))

                    Text(vm.missionAnimal?.scientificName ?? "")
                        .font(.footnote.italic())
                        .foregroundStyle(.secondary)

                    Text("Desafios")
                        .font(.system(size: 17, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 8)

                    ForEach(vm.missionResults, id: \.mission.id) { result in
                        HStack(spacing: 12) {
                            Image(systemName: result.completed ? "checkmark.circle.fill" : "circle")
                                .font(.system(size: 30))
                                .foregroundStyle(result.completed ? Color.green : Color.gray.opacity(0.4))

                            Text(result.mission.title)
                                .font(.system(size: 12))
                                .fixedSize(horizontal: false, vertical: true)

                            Spacer(minLength: 0)
                        }
                        .padding(12)
                        .background(.white, in: RoundedRectangle(cornerRadius: 14))
                    }

                    Text("Fotos enviadas")
                        .font(.system(size: 17, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 8)

                    HStack(spacing: 10) {
                        ForEach(vm.selectedPhotos) { photo in
                            VStack(spacing: 4) {
                                Color.clear
                                    .aspectRatio(1, contentMode: .fit)
                                    .overlay(
                                        Image(uiImage: photo.image)
                                            .resizable()
                                            .scaledToFill()
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 14))

                                Text(photo.pose?.displayName ?? "Sem animal")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .foregroundStyle(.black)
                .padding(.horizontal, 20)
                .padding(.top, 60)
                .padding(.bottom, 110)
            }

            Button {
                vm.showRegistered()
            } label: {
                Text("Próximo")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.vertical, 16)
                    .frame(maxWidth: 260)
                    .background(FaunaPalette.teal, in: Capsule())
            }
            .padding(.bottom, 24)
        }
        .overlay(alignment: .topLeading) {
            Button {
                vm.backToSelection()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.green)
                    .frame(width: 44, height: 44)
                    .background(.ultraThinMaterial, in: Circle())
            }
            .padding(.leading, 20)
            .padding(.top, 8)
        }
    }
}
#Preview {
    ExpeditionMissionCheckView(vm: ExpeditionViewModel())
}
