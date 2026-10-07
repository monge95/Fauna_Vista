//
//  MissionPinsLayer.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 02/10/26.
//

import SwiftUI
import SwiftData

struct MissionPinsLayer: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(ExpeditionLog.self) private var log
    @Environment(AppCoordinator.self) private var coordinator

    @State private var selectedPin: MissionPin?

    var body: some View {
        Group {
            if let activeBiomeId = log.activeBiomeId {
                ForEach(
                    MissionPin.allMissionPins.filter {
                        $0.biomeId == activeBiomeId
                    }
                ) { pin in
                    pinButton(for: pin)
                }
            }
        }
        .sheet(item: $selectedPin) { pin in

            if let animal = findAnimal(for: pin),
               let expedition = findExpedition(for: animal) {

                CompletedMissionSheetView(
                    pin: pin,
                    expedition: expedition
                ) {
                    // Refazer depois
                }

            } else {

                MissionSheetView(pin: pin) {
                    log.activeScientificName = pin.scientificName
                    selectedPin = nil
                    coordinator.push(.Expedition)
                }
            }
        }
    }

    private func pinButton(for pin: MissionPin) -> some View {
        Button {
              selectedPin = pin
          } label: {
              Image(isDiscovered(pin) ? pin.assetsNameDiscovered : pin.assetsName)
                  .resizable()
                  .scaledToFit()
                  .frame(width: 44, height: 49)
                  .clipped()
          }
        .position(
            x: pin.posX,
            y: pin.posY
        )
    }

    private func findAnimal(for pin: MissionPin) -> Animal? {

        let scientificName = pin.scientificName

        let descriptor = FetchDescriptor<Animal>(
            predicate: #Predicate { animal in
                animal.scientificName == scientificName
            }
        )

        return try? modelContext.fetch(descriptor).first
    }

    private func findExpedition(for animal: Animal) -> Expedition? {

        let repository = ExpeditionRepository(
            modelContext: modelContext
        )

        let service = ExpeditionService(
            repository: repository
        )

        do {
            return try service.findExpedition(for: animal)
        } catch {
            print("❌ Erro buscando expedição:", error)
            return nil
        }
    }
    
    private func isDiscovered(_ pin: MissionPin) -> Bool {
        guard let animal = findAnimal(for: pin) else { return false }
        return findExpedition(for: animal) != nil
    }
}


#Preview {
    MissionPinsLayer()
        .environment(PreviewSupport.coordinator)
        .environment(
            PreviewSupport.expeditionLog(biomeId: 1)
        )
}
