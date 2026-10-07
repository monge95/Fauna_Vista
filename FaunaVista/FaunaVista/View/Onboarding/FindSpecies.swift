//
//  Encontre.swift
//  FaunaVista
//
//  Created by Joice Cardoso on 05/10/26.
//

import SwiftUI

struct FindSpecies: View {
    @Environment(AppCoordinator.self) private var coordinator
    var body: some View {
        ZStack {
            Image("EncontreImg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Explore novos\nterritórios")
                    .font(
                        .custom("Belanosima-SemiBold", size: 34))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color("TextOnboarding"))
                    .padding(.top, 80)
                
                Text("Procure animais que enfrentam \n riscos de desaparecer da mata \n e descubra sua importância")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color("TextOnboarding"))
                
                Spacer()
                
                HStack(spacing: 30) {
                    
                    Button (action: {
                        coordinator.pop()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 50)
                    }
                    .glassEffect(.regular, in: .circle)
                    .padding(.bottom, 70)
                    
                    
                    Button (action: {
                        coordinator.push(.observeImg)
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 50)
                    }
                    .glassEffect(.regular, in: .circle)
                    .padding(.bottom, 70)
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    FindSpecies()
}
