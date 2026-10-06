//
//  Encontre.swift
//  FaunaVista
//
//  Created by Joice Cardoso on 05/10/26.
//

import SwiftUI

struct Encontre: View {
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
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 50)
                    }
                    .glassEffect(.regular, in: .circle)
                    .padding(.bottom, 50)
                    
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 50)
                    }
                    .glassEffect(.regular, in: .circle)
                    .padding(.bottom, 50)
                    
                }
            }
        }
    }
}

#Preview {
    Encontre()
}
