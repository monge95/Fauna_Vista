//
//  AnimalTag.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 02/10/26.
//

import SwiftUI

struct AnimalTag: View {

    let text: String
    let backgroundColor: Color
    var textColor: Color = .black

    var body: some View {
        Text(text)
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(textColor)
            .padding(.horizontal, 18)
            .padding(.vertical, 7)
            .background {
                Capsule()
                    .fill(backgroundColor)
            }
    }
}
