
//
//  CompletedMissionSheetView.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 06/10/26.
//

import SwiftUI

struct CompletedMissionSheetView: View {

    @Environment(\.dismiss) private var dismiss

    let pin: MissionPin
    let expedition: Expedition
    let onRedo: () -> Void

    @State private var showRedoConfirmation = false

    var body: some View {
        VStack(spacing: 12) {

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

            CompletedMissionAnimalIdentification(
                animal: expedition.animal
            )

            VStack(alignment: .leading, spacing: 12) {

                Text("Desafios")
                    .font(.system(size: 20, weight: .bold))

                CompletedMissionChallengeCard(
                    completed: expedition.challenge1Completed,
                    objective: pin.missionObjective1
                )

                CompletedMissionChallengeCard(
                    completed: expedition.challenge2Completed,
                    objective: pin.missionObjective2
                )

                CompletedMissionChallengeCard(
                    completed: expedition.challenge3Completed,
                    objective: pin.missionObjective3
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            ExpeditionPhotosSection(
                photos: expedition.photos
            )

            Spacer()

            redoButton
        }
        .foregroundStyle(.black)
        .padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 12)
        .background {
            Color("CardBackground")
                .ignoresSafeArea()
        }
        .presentationDetents([.large])
        .alert(
            "Deseja realmente refazer a expedição?",
            isPresented: $showRedoConfirmation
        ) {
            Button("Cancelar", role: .cancel) { }

            Button("Refazer", role: .destructive) {
                onRedo()
            }
        } message: {
            Text("Todas as fotos tiradas na expedição serão excluídas.")
        }
    }
   
    
   
    
    private var redoButton: some View {
        Button {
            showRedoConfirmation = true
        } label: {
            Label(
                "Refazer expedição",
                systemImage: "arrow.clockwise"
            )
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                Color("buttonColor"),
                in: Capsule()
            )
        }
        .buttonStyle(.plain)
    }
}
