//
//  MissionSheetView.swift
//  FaunaVista
//
//  Created by Felipe Colares Cardoso on 04/10/26.
//

import SwiftUI

struct MissionSheetView: View {

    @Environment(\.dismiss) private var dismiss

    let pin: MissionPin
    let onStart: () -> Void

    var body: some View {
        VStack(spacing: 16) {

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.red)
                        .frame(width: 44, height: 44)
                        .background {
                            Circle()
                                .fill(.white)
                        }
                }
                .buttonStyle(.plain)

                Spacer()
            }

            MissionAnimalIdentification(
                scientificName: pin.scientificName
            )

            VStack(alignment: .leading, spacing: 12) {

                Text("Desafios")
                    .font(.system(size: 20, weight: .bold))

                MissionChallengeCard(
                    number: 1,
                    objective: pin.missionObjective1
                )

                MissionChallengeCard(
                    number: 2,
                    objective: pin.missionObjective2
                )

                MissionChallengeCard(
                    number: 3,
                    objective: pin.missionObjective3
                )
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )

            Spacer()

            Button(action: onStart) {
                Text("Iniciar expedição")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        Color("buttonColor"),
                        in: Capsule()
                    )
            }
        }
        .foregroundStyle(.black)
        .padding(24)
        .background {
            Color("CardBackground")
                .ignoresSafeArea()
        }
        .presentationDetents([.large])
    }
}
