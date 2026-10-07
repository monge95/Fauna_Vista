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
    @Environment(AppCoordinator.self) private var coordinator

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
                        Image(biome.border)
                            .position(x: biome.posX, y: biome.posY)
                    }

                }else {
                    Image(biome.assetCinza)
                        .position(x: biome.posX, y: biome.posY)
                    
                }
                
            }
                
            
         
            MissionPinsLayer()
        }
        .frame(width: 491.8, height: 504.17)
        
        
    }
}
#Preview {
    MapBiome(mapPice: 2)
        .environment(AppCoordinator())
        .environment(PreviewSupport.expeditionLog(biomeId: 4))

}
