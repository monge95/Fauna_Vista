//
//  ExpeditionView.swift
//  Orquestra o fluxo todo da expedição.
//

import SwiftUI
import SwiftData

struct ExpeditionView: View {
    @StateObject private var vm = ExpeditionViewModel()
    @Environment(AppCordinator.self) private var coordinator
    @Environment(\.modelContext) private var modelContext
    @Environment(ExpeditionLog.self) private var log
    @Query private var animals: [Animal]

    private var missionAnimalModel: Animal? {
        guard let name = vm.missionAnimal?.scientificName else { return nil }
        return animals.first { $0.scientificName == name }
    }

    var body: some View {
        Group {
            switch vm.gameState {
            case .start:
                ExpeditionStartView(vm: vm)
            case .playing:
                ExpeditionGameView(vm: vm)
            case .finished:
                ExpeditionFinishedView(vm: vm)
            case .missionCheck:
                ExpeditionMissionCheckView(vm: vm)
            case .registered:
                ExpeditionAnimalRegisteredView(
                    animalName: vm.missionAnimal?.displayName ?? "Animal",
                    scientificName: vm.missionAnimal?.scientificName ?? "",
                    biome: missionAnimalModel?.biome ?? 2
                ) {
                    registerAnimal()
                    vm.returnToStart()
                    coordinator.rezet()   // limpa o path e abre a aba Coleção
                }
            }
        }
        .navigationBarBackButtonHidden(vm.gameState != .start)
        .onAppear {
            let level = ExpeditionLevel.level(for: log.activeScientificName)
                ?? ExpeditionLevel.all[0]   // fallback para não quebrar
            vm.configure(level: level)
        }
    }

    // Marca como descoberto e salva a expedição (missões + 3 fotos) no SwiftData.
    private func registerAnimal() {
        guard let animal = missionAnimalModel else { return }
        animal.discovered = true

        let selected = vm.selectedPhotos
        // ExpeditionRepository exige exatamente 3 fotos.
        if selected.count == 3 {
            let r = vm.missionResults.map(\.completed)
            let photos = selected.map {
                ExpeditionPhotoModel(
                    image: $0.image.jpegData(compressionQuality: 0.8),
                    rating: $0.stars
                )
            }
            let service = ExpeditionService(
                repository: ExpeditionRepository(modelContext: modelContext)
            )
            do {
                try service.finishExpedition(
                    biome: animal.biome,
                    animal: animal,
                    challenge1Completed: r[0],
                    challenge2Completed: r[1],
                    challenge3Completed: r[2],
                    photos: photos
                )
            } catch ExpeditionServiceError.expeditionAlreadyExists {
                // Já existe expedição deste animal: mantém a anterior.
            } catch {
                print("Erro ao salvar expedição:", error)
            }
        }

        try? modelContext.save()
    }
}
