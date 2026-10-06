//
//  CompletedMissionChallengeCard.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 06/10/26.
//

import SwiftUI

struct CompletedMissionChallengeCard: View {

    let completed: Bool
    let objective: String

    var body: some View {
        HStack(spacing: 16) {

            Image(systemName: "checkmark")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 44, height: 44)
                .background {
                    Circle()
                        .fill(
                            completed
                            ? Color.green
                            : Color.gray.opacity(0.35)
                        )
                }

            Text(objective)
                .font(.system(size: 15))
                .foregroundStyle(.black)
                .multilineTextAlignment(.leading)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .frame(minHeight: 76)
        .background {
            RoundedRectangle(cornerRadius: 18)
                .fill(.white)
        }
    }
}
