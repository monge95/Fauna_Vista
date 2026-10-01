//
//  MapBiome.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 30/09/26.
//

//
//  mapButoon.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 29/09/26.
//
import SwiftUI

struct MapBiome: View {
    @Environment(AppCordinator.self) private var coordinator

    @State var mapPice: Int? = 0
    
    var body: some View {
        
        ZStack {
            Image("map")
                .resizable()
                .scaledToFit()
            
         
            ForEach(MapPiece.todosOsBiomas) { biome in
                if biome.id == mapPice{
                    ZStack{
                        Image(biome.assetColorido)
                            .position(x: biome.posX, y: biome.posY)
                        Image("borda\(biome.assetColorido)")
                            .position(x: biome.posX, y: biome.posY)
                    }

                }else {
                    Image(biome.assetCinza)
                        .position(x: biome.posX, y: biome.posY)
                    
                }
                
            }
                
            
         
            
        }
        .frame(width: 491.8, height: 504.17)
        
    }
}
#Preview {
    MapBiome(mapPice: 2)
        .environment(AppCordinator())
}
