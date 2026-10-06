//
//  Observe.swift
//  FaunaVista
//
//  Created by Joice Cardoso on 06/10/26.
//

import SwiftUI

struct Observe: View {
    var body: some View {
        ZStack {
            Image("ObserveImg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Observar\nFotografar\nIdentificar")
                    .font(
                        .custom("Belanosima-SemiBold", size: 34))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color("TextOnboarding"))
                    .padding(.top, 80)
                
                Text("Encontre uma espécie, registre\no momento e descubra quem\nestá diante da sua câmera")
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
    Observe()
}
