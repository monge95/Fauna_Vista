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

                // Título e subtítulo
                VStack(spacing: 6) {
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
                .padding(.horizontal, 20)

                // Mapa escala para o espaço que sobra entre título e barra de progresso
                FitToSpace(designSize: mapDesignSize) {
                    MapBiome(mapPice: log.activeBiomeId)
                }
                .frame(maxHeight: .infinity)

                // Barra de progresso SEMPRE colada embaixo
                // (antes estava dentro de um GeometryReader sem altura, que
                //  ocupava todo o espaço livre e jogava a barra para o topo)
                MissionProgress()
                    .frame(maxWidth: 520)
                    .padding(.horizontal, max(20, geo.size.width * 0.12))
                    .padding(.bottom, 16)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .background { ScreenBackground(name: "BackGroundBiome") }
    }
}

#Preview {
    BiomeView()
        .environment(PreviewSupport.coordinator)
        .environment(PreviewSupport.expeditionLog)
}
