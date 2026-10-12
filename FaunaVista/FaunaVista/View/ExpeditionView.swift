// ExpeditionView.swift
// FaunaVista
//
// Orquestra o fluxo todo da expedição.
//

import SwiftUI
import SwiftData

struct ExpeditionView: View {

    @State private var vm = ExpeditionViewState()

    @Environment(AppCoordinator.self)
    private var coordinator

    @Environment(\.modelContext)
    private var modelContext

    @Environment(ExpeditionLog.self)
    private var log

    @Query
    private var animals: [Animal]

    // MARK: - Animal da missão no SwiftData

    private var missionAnimalModel: Animal? {

        guard let name = vm.missionAnimal?.scientificName
        else {
            return nil
        }

        return animals.first {
            $0.scientificName == name
        }
    }

    // MARK: - Body

    var body: some View {

        ZStack {

            Group {

                switch vm.gameState {

                case .start:

                    ExpeditionStartView(
                        vm: vm
                    )

                case .playing:

                    ExpeditionGameView(
                        vm: vm
                    )

                case .finished:

                    ExpeditionFinishedView(
                        vm: vm
                    )

                case .missionCheck:

                    ExpeditionMissionCheckView(
                        vm: vm
                    )

                case .registered:
                                    // Verifica se o usuário tem fotos e completou pelo menos o primeiro desafio (índice 0)
                                    let isDiscovered = !vm.selectedPhotos.isEmpty && (vm.missionResults.first?.completed == true)

                                    ExpeditionAnimalRegisteredView(
                                        animalName:
                                            vm.missionAnimal?.displayName
                                            ?? "Animal",

                                        scientificName:
                                            vm.missionAnimal?.scientificName
                                            ?? "",

                                        biome:
                                            missionAnimalModel?.biome
                                            ?? 2,
                                            
                                        isDiscovered: isDiscovered

                                    ) {

                                        if isDiscovered {
                                            if let animal = registerAnimal() {
                                                vm.returnToStart()
                                                coordinator.push(
                                                    .registro(animal)
                                                )
                                            }
                                        } else {
                                            vm.cancelExpedition()
                                            coordinator.pop()
                                        }
                                    }
                }
            }

            // MARK: - Transição para iniciar a expedição

            if vm.isStartingExpedition {

                Color.black
                    .opacity(vm.transitionOpacity)
                    .ignoresSafeArea()
                    .zIndex(10)
                    .allowsHitTesting(true)

                /*if vm.countdownNumber > 0 {

                    Text("Começando em \(vm.countdownNumber)")
                        .font(
                            .system(
                                size: 46,
                                weight: .bold,
                                design: .rounded
                            )
                        )
                        .foregroundStyle(.white)
                        .transition(.opacity)
                        .zIndex(11)
                }*/
            }
        }

        .animation(
            .easeInOut(duration: 0.4),
            value: vm.countdownNumber
        )

        .navigationBarBackButtonHidden(
            vm.gameState != .start
        )

        .onAppear {

            let level =
                ExpeditionLevel.level(
                    for: log.activeScientificName
                )
                ?? ExpeditionLevel.all[0]

            vm.configure(
                level: level
            )
        }
    }

    // MARK: - Registrar animal

    private func registerAnimal() -> Animal? {

        guard let animal = missionAnimalModel
        else {
            return nil
        }

        animal.discovered = true

        let selected =
            vm.selectedPhotos

        // A expedição precisa de exatamente 3 fotos.

        if selected.count == 3 {

            let results =
                vm.missionResults.map(\.completed)

            let photos =
                selected.map {

                    ExpeditionPhotoModel(
                        image:
                            $0.image.jpegData(
                                compressionQuality: 0.8
                            ),

                        rating:
                            $0.stars
                    )
                }

            let service =
                ExpeditionService(
                    repository:
                        ExpeditionRepository(
                            modelContext:
                                modelContext
                        )
                )

            do {

                try service.finishExpedition(

                    biome:
                        animal.biome,

                    animal:
                        animal,

                    challenge1Completed:
                        results[0],

                    challenge2Completed:
                        results[1],

                    challenge3Completed:
                        results[2],

                    photos:
                        photos
                )

            } catch ExpeditionServiceError.expeditionAlreadyExists {

                // A expedição desse animal já existe.
                // Mantém o registro anterior.

            } catch {

                print(
                    "Erro ao salvar expedição:",
                    error
                )
            }
        }

        try? modelContext.save()

        return animal
    }
}

// MARK: - Preview

#Preview {

    ExpeditionView()
        .modelContainer(
            PreviewSupport.container
        )
        .environment(
            PreviewSupport.coordinator
        )
        .environment(
            PreviewSupport.expeditionLog
        )
}
