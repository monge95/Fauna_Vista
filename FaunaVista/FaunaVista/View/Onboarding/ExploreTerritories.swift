//
//  Encontre.swift
//  FaunaVista
//
//  Created by Joice Cardoso on 05/10/26.
 
import SwiftUI

struct ExploreTerritories: View {
    @Environment(AppCoordinator.self) private var coordinator

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 10) {
                Text("Explore novos\nterritórios")
                    .font(.custom("Belanosima-SemiBold", size: 34))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.6)
                    .foregroundStyle(Color("TextOnboarding"))
                    .padding(.top, geo.size.height * 0.10)

                Text("Procure animais que enfrentam \n riscos de desaparecer da mata \n e descubra sua importância")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundStyle(Color("TextOnboarding"))

                Spacer(minLength: 16)

                OnboardingNavButtons(
                    onBack: { coordinator.pop() },
                    onNext: { coordinator.push(.observeImg) }
                )
                .padding(.bottom, max(24, geo.size.height * 0.09))
            }
            .padding(.horizontal, 24)
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .background { ScreenBackground(name: "EncontreImg") }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ExploreTerritories()
        .environment(AppCoordinator())
}
