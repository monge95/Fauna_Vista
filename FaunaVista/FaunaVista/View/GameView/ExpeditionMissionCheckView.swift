
//  ExpeditionMissionCheckView.swift
//  FaunaVista
//
//  Tela de verificação das missões e fotos selecionadas.
//

import SwiftUI

struct ExpeditionMissionCheckView: View {

    let vm: ExpeditionViewState
   // @ObservedObject var vm: ExpeditionViewModel
    
    private var currentMissionPin: MissionPin? {
        guard let scientificName = vm.missionAnimal?.scientificName else {
            return nil
        }

        return MissionPin.allMissionPins.first {
            $0.scientificName == scientificName
        }
    }
    
    private var missionObjectives: [String] {
        guard let pin = currentMissionPin else {
            return []
        }

        return [
            pin.missionObjective1,
            pin.missionObjective2,
            pin.missionObjective3
        ]
    }

    var body: some View {
        ZStack(alignment: .bottom) {

            FaunaPalette.beige
                .ignoresSafeArea()

            ScrollView {

                VStack(spacing: 14) {

                    // MARK: - Animal

                    Image(
                        IllustrationAnimal.imageName(
                            for: vm.missionAnimal?.scientificName ?? "",
                            discovered: true
                        )
                    )
                    .resizable()
                    .scaledToFit()
                    .frame(height: 190)

                    Text(
                        vm.missionAnimal?.displayName ?? "Animal"
                    )
                    .font(.system(size: 20, weight: .bold))

                    Text(
                        vm.missionAnimal?.scientificName ?? ""
                    )
                    .font(.footnote.italic())
                    .foregroundStyle(.secondary)

                    // MARK: - Desafios

                    Text("Desafios")
                        .font(.system(size: 17, weight: .bold))
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding(.top, 8)

                    ForEach(
                        Array(vm.missionResults.enumerated()),
                        id: \.element.mission.id
                    ) { index, result in

                        HStack(spacing: 12) {

                            Image(
                                systemName: result.completed
                                    ? "checkmark.circle.fill"
                                    : "circle"
                            )
                            .font(.system(size: 30))
                            .foregroundStyle(
                                result.completed
                                    ? Color.green
                                    : Color.gray.opacity(0.4)
                            )

                            Text(
                                missionObjectives.indices.contains(index)
                                    ? missionObjectives[index]
                                    : result.mission.title
                            )
                            .font(.system(size: 12))
                            .fixedSize(horizontal: false, vertical: true)

                            Spacer(minLength: 0)
                        }
                        .padding(12)
                        .background(
                            .white,
                            in: RoundedRectangle(cornerRadius: 14)
                        )
                    } 

                    // MARK: - Fotos

                    Text("Fotos enviadas")
                        .font(.system(size: 17, weight: .bold))
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding(.top, 8)

                    HStack(spacing: 10) {

                        ForEach(vm.selectedPhotos) { photo in

                            VStack(spacing: 4) {

                                Color.clear
                                    .aspectRatio(
                                        1,
                                        contentMode: .fit
                                    )
                                    .overlay(
                                        Image(uiImage: photo.image)
                                            .resizable()
                                            .scaledToFill()
                                    )
                                    .clipShape(
                                        RoundedRectangle(
                                            cornerRadius: 14
                                        )
                                    )

                                Text(
                                    photo.pose?.displayName
                                    ?? "Sem animal"
                                )
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

            // MARK: - Próximo

            Button {
                vm.showRegistered()
            } label: {

                Text("Próximo")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.vertical, 16)
                    .frame(maxWidth: 260)
                    .background(
                        FaunaPalette.teal,
                        in: Capsule()
                    )
            }
            .padding(.bottom, 24)
        }

        // MARK: - Voltar

        .overlay(alignment: .topLeading) {

            Button {
                vm.backToSelection()
            } label: {

                Image(systemName: "chevron.left")
                    .font(
                        .system(
                            size: 22,
                            weight: .bold
                        )
                    )
                    .foregroundStyle(.green)
                    .frame(
                        width: 44,
                        height: 44
                    )
                    .background(
                        .ultraThinMaterial,
                        in: Circle()
                    )
            }
            .padding(.leading, 20)
            .padding(.top, 8)
        }
    }
}

#Preview {
    ExpeditionMissionCheckView(
        vm: ExpeditionViewState()
    )
}
