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
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 38, height: 38)
                .background {
                    Circle()
                        .fill(
                            completed
                            ? Color.green
                            : Color.gray.opacity(0.35)
                        )
                }

            Text(objective)
                .font(.system(size: 13))
                .foregroundStyle(.black)
                .multilineTextAlignment(.leading)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .frame(minHeight: 50)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
        }
    }
}
