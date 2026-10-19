//
//  Explore.swift
//  FaunaVista
//
//  Created by Joice Cardoso on 05/10/26.
//
import SwiftUI

struct FindSpecies: View {
    @Environment(AppCoordinator.self) private var coordinator

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 10) {
                // Quebra de linha explícita + redução automática:
                // o texto não quebra mais no meio de forma estranha.
                Text("Encontre espécies\nameaçadas")
                    .font(.custom("Belanosima-SemiBold", size: 34))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.6)
                    .padding(.top, geo.size.height * 0.10)

                Spacer(minLength: 16)

                OnboardingNavButtons(
                    onBack: { coordinator.pop() },
                    onNext: { coordinator.push(.exploreTerritories) }
                )
                .padding(.bottom, max(24, geo.size.height * 0.09))
            }
            .padding(.horizontal, 24)
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .background { ScreenBackground(name: "ExploreImg") }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    FindSpecies()
        .environment(AppCoordinator())
}
