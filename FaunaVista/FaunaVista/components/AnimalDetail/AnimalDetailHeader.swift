//
//  AnimalDetailHeader.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 02/10/26.
//

import SwiftUI

struct AnimalDetailHeader: View {

    @Environment(\.dismiss) private var dismiss

    let title: String

    var body: some View {
        ZStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(Color("VerdeBackButton"))
                        .frame(width: 44, height: 44)
                        .background {
                            Circle()
                                .fill(.ultraThinMaterial)
                        }
                }
                .buttonStyle(.plain)

                Spacer()
            }

            Text(title)
                .font(.system(size: 26, weight: .semibold))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(maxWidth: 230)
        }
        .frame(minHeight: 100)
    }
}
