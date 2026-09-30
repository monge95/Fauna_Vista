//
//  mapButoon.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 29/09/26.
//
import SwiftUI

struct MapButoon: View {
    @Environment(AppCordinator.self) private var coordinator
    
    @Environment(ExpeditionLog.self) private var log
    
    var body: some View {
        ZStack {
            Image("map")
                .resizable()
                .scaledToFit()
            
         
            ForEach(MapPiece.todosOsBiomas) { bioma in
                Button(action: {
                    log.activeBiomeId = bioma.id
                    coordinator.push(.Biome)
                }) {
                    Image(bioma.assetColorido)
                }
                .buttonStyle(.plain)
                .contentShape(bioma.shape)
                .position(x: bioma.posX, y: bioma.posY)
            }
            
            Image("Image")
                .allowsHitTesting(false)
            
        }
        .frame(width: 491.8, height: 504.17)
    }
}

#Preview {
    MapButoon()
        .environment(AppCordinator())
}
