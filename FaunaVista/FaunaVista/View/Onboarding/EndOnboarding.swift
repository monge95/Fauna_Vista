//
//  Comecou.swift
//  FaunaVista
//
//  Created by Joice Cardoso on 06/10/26.

import SwiftUI

struct EndOnboarding: View {
    @Environment(AppCoordinator.self) private var coordinator
    @AppStorage("hasCompletedOnboarding")
    private var hasCompletedOnboarding = false

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 10) {
                Text("Sua expedição\nestá começando")
                    .font(.custom("Belanosima-SemiBold", size: 34))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.6)
                    .foregroundStyle(Color("TextOnboarding"))

                Text("Explore, fotografe e complete\nsua coleção de descobertas\npela fauna brasileira")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundStyle(Color("TextOnboarding"))

                Spacer(minLength: 16)

                Button {
                    coordinator.resetOnboarding()
                    hasCompletedOnboarding = true
                } label: {
                    Text("Iniciar")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.textIcon)
                        .frame(maxWidth: .infinity)
                        .frame(height: 46)
                        .background(Color("TextOnboarding"))
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
        .background { ScreenBackground(name: "ComecouImg") }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    EndOnboarding()
        .environment(AppCoordinator())
}
