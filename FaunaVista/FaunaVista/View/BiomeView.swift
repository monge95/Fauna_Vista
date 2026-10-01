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
        
        MapBiome(mapPice: log.activeBiomeId)
        
    }
}

#Preview {
    BiomeView()
        .environment(AppCordinator())

}
