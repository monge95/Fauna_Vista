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
                Image("AppCordinator")
                    .resizable()
                    .scaledToFill()
                
                Image("cloud")

              MapButoon()
            }
            .ignoresSafeArea()
        
    }
}
#Preview {
    MapView()
        .environment(AppCordinator())
}
