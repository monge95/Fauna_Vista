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
        VStack(spacing: 20) {
            Image(systemName: "map.fill")
                .font(.system(size: 60))
                .foregroundColor(.green)
            
            Text("Tela Base do Mapa")
                .font(.title)
                .bold()
            
           
            Button("Explorar Bioma 1") {
                coordinator.push(.Biome (id: 1))
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
        }
        .ignoresSafeArea()

    }
}
