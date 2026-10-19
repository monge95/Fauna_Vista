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
        ZStack {
            Image("ExploreImg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Encontre espécies ameaçadas")
                    .font(
                        .custom("Belanosima-SemiBold", size: 34))
                    .multilineTextAlignment(.center)
                    .padding(.top, 80)
                
                
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
                        coordinator.push(.exploreTerritories)
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
    ExploreTerritories()
}
