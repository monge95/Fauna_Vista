//
//  mapView.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 28/09/26.
//
import SwiftUI

struct MapView: View {
    @Environment(AppCordinator.self) private var coordinator
    
    
    
    var body: some View {
        
            
            
            ZStack{
                Image("BackGroundMap")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack{
                    Spacer()
                    HStack{
                        VStack(spacing: 5){
                            Text("Biomas do Brasil")
                                .font(.custom("Belanosima-SemiBold", size: 35))
                                .foregroundColor(Color("BackGroundColor"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Toque no bioma para explorar")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(5)
                                .padding(.horizontal, 10)
                                .background(Color("LightGreenProgress"))
                                .cornerRadius(20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Button(action: {
                            coordinator.push(.information)
                        }) {
                            Image(systemName: "info")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                        }
                        .frame(width: 44, height: 44)
                        .buttonStyle(.plain)
                       
                        .background(
                            Circle()
                                .fill(.ultraThinMaterial)
                        )
                       
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        colors: [.white.opacity(0.8), .clear, .white.opacity(0.2)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1.5
                                )
                        )
                        
                        .shadow(color: .black.opacity(0.15), radius: 4, x: 2, y: 4)
                    }
                    .padding(.horizontal, 70)
                    ZStack{
                    Image("cloud")
                        
                        
                        MapButton()
                            .padding(.top, 60)
                    }
                    Spacer()
                }
                
            }
    }
}
#Preview {
    MapView()
        .environment(AppCordinator())
}
