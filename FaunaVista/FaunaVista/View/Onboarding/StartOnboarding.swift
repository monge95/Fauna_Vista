//
//  startexpedition.swift
//  FaunaVista
//
//  Created by Joice Cardoso on 05/10/26.
 

import SwiftUI

struct StartOnboarding: View {
    @Environment(AppCoordinator.self) private var coordinator

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 10) {
                Text("Sua expedição\ncomeça aqui")
                    .font(.custom("Belanosima-SemiBold", size: 34))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.6)

                Text("Vem explorar os biomas do Brasil \nem uma expedição virtual")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer(minLength: 16)

                Button(action: {
                    coordinator.push(.findSpecies)
                }) {
                    Text("Avançar")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 46)
                        .background(Color.button)
                        .clipShape(Capsule())
                }
                .frame(maxWidth: 360)
                .padding(.horizontal, geo.size.width * 0.2)
            }
            .padding(.horizontal, 24)
            .padding(.top, geo.size.height * 0.19)
            .padding(.bottom, max(24, geo.size.height * 0.09))
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .background { ScreenBackground(name: "ExpedicaoComecaImg") }
    }
}

#Preview {
    StartOnboarding()
}
