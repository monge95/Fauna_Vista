//
//  InformationOptionCard.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 05/10/26.
//
import SwiftUI

struct InformationOptionCard: View {

    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 16) {

            Image(systemName: icon)
                .font(.system(size: 52, weight: .semibold))
                .foregroundStyle(Color("InformationPurple"))
                .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.black)

                Text(description)
                    .font(.system(size: 14))
                    .foregroundStyle(.black.opacity(0.7))
                    .multilineTextAlignment(.leading)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color("InformationPurple"))
        }
        .padding(.horizontal, 18)
        .frame(maxWidth: .infinity)
        .frame(height: 128)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("InformationCardBackground"))
        }
    }
}
