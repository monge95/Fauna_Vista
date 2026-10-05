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
            Text(pin.missionObjective1)
                .font(.title2.bold())
                .multilineTextAlignment(.center)

            Text(pin.animalName)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 10) {
                Text(pin.missionObjective2)
                Text(pin.missionObjective3).bold()
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Button(action: onStart) {
                Text("Começar expedição")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(FaunaPalette.teal, in: Capsule())
            }
        }
        .foregroundStyle(.black)
        .padding(24)
        .presentationDetents([.medium])
    }
}
