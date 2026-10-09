//
//  startexpedition.swift
//  FaunaVista
//
//  Created by Joice Cardoso on 05/10/26.
//

import SwiftUI

struct StartOnboarding: View {
    @Environment(AppCoordinator.self) private var coordinator
    var body: some View {
        ZStack {
            Image("ExpedicaoComecaImg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Sua expedição\ncomeça aqui")
                    .font(
                        .custom("Belanosima-SemiBold", size: 34))
                    .multilineTextAlignment(.center)
                
                Text("Vem explorar os biomas do Brasil \nem uma expedição virtual")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Button (action: {
                    coordinator.push(.exploreTerritories)
                }) {
                    Text("Avançar")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 46)
                        .background (Color.button)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 80)
            }
            .padding(.bottom, 70)
            .padding(.top, 150)
            
        }
    }
}

#Preview {
    StartOnboarding()
}
