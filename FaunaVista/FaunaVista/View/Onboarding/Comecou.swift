//
//  Comecou.swift
//  FaunaVista
//
//  Created by Joice Cardoso on 06/10/26.
//

import SwiftUI

struct Comecou: View {
    var body: some View {
        ZStack {
            Image("ComecouImg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Sua expedição\nestá começando")
                    .font(
                        .custom("Belanosima-SemiBold", size: 34))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color("TextOnboarding"))
                
                Text("Explore, fotografe e complete\nsua coleção de descobertas\npela fauna brasileira")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color("TextOnboarding"))
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Iniciar")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.texIcon)
                        .frame(maxWidth: .infinity)
                        .frame(height: 46)
                        .background (Color("TextOnboarding"))
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 80)
            }
            .padding(.bottom, 50)
            .padding(.top, 150)
            
        }
    }
}

#Preview {
    Comecou()
}

