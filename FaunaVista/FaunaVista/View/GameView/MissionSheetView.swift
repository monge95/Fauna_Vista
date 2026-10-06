//
//  MissionSheetView.swift
//  FaunaVista
//
//  Created by Felipe Colares Cardoso on 04/10/26.
//

import SwiftUI

struct MissionSheetView: View {

    let pin: MissionPin
    let onStart: () -> Void

    var body: some View {
        VStack(spacing: 16) {

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
                        FaunaPalette.teal,
                        in: Capsule()
                    )
            }
        }
        .foregroundStyle(.black)
        .padding(24)
        .presentationDetents([.large])
    }
}
