//
//  MissionPinsLayer.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 02/10/26.
//

import SwiftUI

struct MissionPinsLayer: View {
        @Environment(ExpeditionLog.self) private var log
        @State private var selectedPin: MissionPin? = nil
        @Environment(AppCordinator.self) private var coordinator
        var body: some View {
            Group {
                if let activeBiomeId = log.activeBiomeId {
                    ForEach(
                        MissionPin.allMissionPins.filter { $0.biomeId == activeBiomeId }
                    ) { pin in
                        pinButton(for: pin)
                    }
                }
            }
            .sheet(item: $selectedPin) { pin in
                MissionSheetView(pin: pin) {
                    log.activeScientificName = pin.scientificName
                    selectedPin = nil
                    coordinator.push(.Expedition)
                 }
                }
                   // .padding(.bottom, 24)
                
            
            
        }

        private func pinButton(for pin: MissionPin) -> some View {
            Button {
                selectedPin = pin     
            } label: {
                Image(pin.assetsName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 49)
                    .clipped()
            }
            .position(x: pin.posX, y: pin.posY)
        }
    }

#Preview {
    MissionPinsLayer()
        .environment(PreviewSupport.coordinator)
        .environment(PreviewSupport.expeditionLog(biomeId: 1))
}
