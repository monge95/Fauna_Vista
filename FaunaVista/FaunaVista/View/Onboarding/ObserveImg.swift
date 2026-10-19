//
//  Observe.swift
//  FaunaVista
//
//  Created by Joice Cardoso on 06/10/26.
//
 
import SwiftUI

struct ObserveImg: View {
    @Environment(AppCoordinator.self) private var coordinator

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 10) {
                Text("Observar\nFotografar\nIdentificar")
                    .font(.custom("Belanosima-SemiBold", size: 34))
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .minimumScaleFactor(0.6)
                    .foregroundStyle(Color("TextOnboarding"))
                    .padding(.top, geo.size.height * 0.10)

                Text("Encontre uma espécie, registre\no momento e descubra quem\nestá diante da sua câmera")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundStyle(Color("TextOnboarding"))

                Spacer(minLength: 16)

                OnboardingNavButtons(
                    onBack: { coordinator.pop() },
                    onNext: { coordinator.push(.endOnboarding) }
                )
                .padding(.bottom, max(24, geo.size.height * 0.09))
            }
            .padding(.horizontal, 24)
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .background { ScreenBackground(name: "ObserveImg") }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ObserveImg()
        .environment(AppCoordinator())
}
