//
//  mapView.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 28/09/26.
////
 

import SwiftUI
import SwiftData

struct MapView: View {
    @Environment(AppCoordinator.self) private var coordinator

    /// Tamanho em que o mapa + nuvem foram desenhados (MapButton 491.8 x 504.17 + 50 de respiro no topo).
    private let mapDesignSize = CGSize(width: 492, height: 554)

    var body: some View {
        GeometryReader { geo in
            // Margem lateral proporcional (antes era 70 fixo)
            let side = max(24, min(70, geo.size.width * 0.17))

            VStack(spacing: 8) {

                // Título + botão de informação
                HStack(spacing: 12) {
                    Text("Biomas do Brasil")
                        .font(.custom("Belanosima-SemiBold", size: 35))
                        .foregroundColor(Color("BackGroundColor"))
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    infoButton
                }
                .padding(.horizontal, side)
                .padding(.top, 8)

                // Dica
                Text("Toque no bioma para explorar")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .padding(5)
                    .padding(.horizontal, 10)
                    .background(Color("LightGreenProgress"))
                    .cornerRadius(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, side)
                    .padding(.trailing, side)

                // Mapa escalado para ocupar o espaço que sobrou
                FitToSpace(designSize: mapDesignSize) {
                    ZStack {
                        Image("cloud")
                            .padding(.bottom, 30)

                        MapButton()
                            .padding(.top, 50)
                    }
                }
                .frame(maxHeight: .infinity)
                .padding(.bottom, 8)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .background { ScreenBackground(name: "BackGroundMap") }
    }

    private var infoButton: some View {
        Button(action: {
            coordinator.push(.information)
        }) {
            Image(systemName: "info")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
        }
        .frame(width: 44, height: 44)
        .buttonStyle(.plain)
        .background(
            Circle()
                .fill(.ultraThinMaterial)
        )
        .overlay(
            Circle()
                .stroke(
                    LinearGradient(
                        colors: [.white.opacity(0.8), .clear, .white.opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.5
                )
        )
        .shadow(color: .black.opacity(0.15), radius: 4, x: 2, y: 4)
        .fixedSize()
        .layoutPriority(1)
    }
}

#Preview {
    MapView()
        .environment(PreviewSupport.coordinator)
        .environment(PreviewSupport.expeditionLog)
}
