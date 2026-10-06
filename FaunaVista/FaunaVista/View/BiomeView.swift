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
                .position(x: geo.size.width / 2, y: geo.size.height / 2)
            }
            .ignoresSafeArea()
            
            VStack{
                ForEach(MapPiece.todosOsBiomas){ bio in
                    if log.activeBiomeId == bio.id{
                        Text(bio.name)
                            .font(.custom("Belanosima-SemiBold", size: 35))
                            .foregroundColor(Color("BackGroundColor"))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                Text("Explore, registre as espécies \n deste bioma")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color("BackGroundColor"))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                MapBiome(mapPice: log.activeBiomeId)
                Spacer()
                GeometryReader{ geo in
                    MissionProgress() 
                        .padding(.horizontal, geo.size.width * 0.15)
                    
                }
                    
            }
            
            
            
        }
        
        
        
    }
}

#Preview {
    BiomeView()
        .environment(PreviewSupport.coordinator)
        .environment(PreviewSupport.expeditionLog)
}
