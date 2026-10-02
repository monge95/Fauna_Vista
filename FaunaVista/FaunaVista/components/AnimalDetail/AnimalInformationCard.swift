//
//  AnimalInformationCard.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 02/10/26.
//

import SwiftUI

struct AnimalInformationCard: View {

    let information: AnimalInformation

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text("Informações do animal")
                .font(.system(size: 24, weight: .bold))

            informationSection(
                title: "Características",
                text: information.characteristics
            )

            informationSection(
                title: "Comportamento",
                text: information.behavior
            )

            informationSection(
                title: "Você sabia?",
                text: information.curiosity
            )

            informationSection(
                title: "Ameaças",
                text: information.threats
            )
        }
        .foregroundStyle(.black)
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.white))
        }
    }

    private func informationSection(
        title: String,
        text: String
    ) -> some View {

        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 18, weight: .bold))

            Text(text)
                .font(.system(size: 16))
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
        }
    }
}
