//
//  biomeView.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 28/09/26.
 

import SwiftUI

struct BiomeView: View {
    @Environment(AppCoordinator.self) private var coordinator
    @Environment(ExpeditionLog.self) private var log

    private let mapDesignSize = CGSize(width: 491.8, height: 504.17)

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 10) {

                VStack(spacing: 0) {
                    ForEach(MapPiece.todosOsBiomas) { bio in
                        if log.activeBiomeId == bio.id {
                            Text(bio.name)
                                .font(.custom("Belanosima-SemiBold", size: 35))
                                .foregroundColor(Color("BackGroundColor"))
                                .lineLimit(1)
                                .minimumScaleFactor(0.6)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }

                    Text("Explore, registre as espécies \n deste bioma")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color("BackGroundColor"))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.top, -geo.size.height * 0.09)
                .padding(.horizontal, 20)

      
                FitToSpace(designSize: mapDesignSize) {
                    MapBiome(mapPice: log.activeBiomeId)
                }
                .frame(width: geo.size.width * 1.25)
                .ignoresSafeArea()
                


            
                MissionProgress()
                    .frame(maxWidth: 520)
                    .padding(.horizontal, max(20, geo.size.width * 0.12))
                    .padding(.bottom, 16)
                Spacer(minLength: 0)
            }
            .padding(.top, 0)
            .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
        }
        .background { ScreenBackground(name: "BackGroundBiome") }
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    BiomeView()
        .environment(PreviewSupport.coordinator)
        .environment(PreviewSupport.expeditionLog)
}
