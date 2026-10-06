//
//  MissionChallengeCard.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 05/10/26.
//

import SwiftUI

struct MissionChallengeCard: View {

    let number: Int
    let objective: String

    var body: some View {
        HStack(spacing: 16) {

            Text("\(number)")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 44, height: 44)
                .background {
                    Circle()
                        .fill(Color("buttonColor"))
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
