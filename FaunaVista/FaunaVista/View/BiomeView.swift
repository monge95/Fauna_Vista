//
//  biomeView.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 28/09/26.
//

import SwiftUI


struct BiomeView: View {
    @Environment(AppCordinator.self) private var coordinator
   
    @Environment(ExpeditionLog.self) private var log

    var body: some View {
        ZStack{
            GeometryReader { geo in
                Image("BackGroundBiome")
                    .resizable()
                    .frame(width: geo.size.width + 10, height: geo.size.height+10)
                .position(x: geo.size.width / 2, y: geo.size.height / 2)             }
            .ignoresSafeArea()
            MapBiome(mapPice: log.activeBiomeId)
            
            
            MissionPinsLayer()
            
            
            
        }
        
        
        
    }
}

#Preview {
    BiomeView()
        .environment(PreviewSupport.coordinator)
        .environment(PreviewSupport.expeditionLog)
}
