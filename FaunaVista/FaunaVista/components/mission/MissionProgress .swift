//
//  MissionProgress .swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 03/10/26.
//
//
//  MissionProgress.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 03/10/26.
//

import SwiftUI
import SwiftData

struct MissionProgress: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(ExpeditionLog.self) private var log

    
    private let maxChallenges = 6

    @State private var percentage: Int = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Progresso")
                .font(.system(size: 18, weight: .bold))

            HStack {
                Text("Espécies registradas")
                    .font(.system(size: 12, weight: .regular))

                Spacer()

                Text("\(percentage)%")
                    .font(.system(size: 12, weight: .regular))
            }

            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.green.opacity(0.25))
                        .frame(height: 10)

                    Capsule()
                        .fill(Color.green)
                        .frame(width: geo.size.width * CGFloat(percentage) / 100, height: 10)
                        .animation(.easeInOut(duration: 0.4), value: percentage)
                }
            }
            .frame(height: 10)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.backGround)
        .cornerRadius(16)
        .task(id: log.activeBiomeId) {
            calculateProgress()
        }
    }

    private func calculateProgress() {
        guard let biomeId = log.activeBiomeId else {
            percentage = 0
            return
        }

        let descriptor = FetchDescriptor<Expedition>(
            predicate: #Predicate { $0.biome == biomeId }
        )

        let expeditions = (try? modelContext.fetch(descriptor)) ?? []

        let trues = expeditions.reduce(0) { sum, expedition in
            sum
                + (expedition.challenge1Completed ? 1 : 0)
                + (expedition.challenge2Completed ? 1 : 0)
                + (expedition.challenge3Completed ? 1 : 0)
        }

    
        percentage = trues * 100 / maxChallenges
    }
}

#Preview {
    MissionProgress()
        .modelContainer(seedPreviewContainer())
        .environment(previewLog())
}

/// Instância local do log, só para o preview, com o bioma já setado
private func previewLog() -> ExpeditionLog {
    let log = ExpeditionLog()
    log.activeBiomeId = 0
    return log
}

/// Cria um banco em memória já populado com dados de teste
private func seedPreviewContainer() -> ModelContainer {
    let container = try! ModelContainer(
        for: Animal.self, Expedition.self, ExpeditionPhotoModel.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    let context = container.mainContext

    let animal1 = Animal(
        taxonID: 12345,
        commonName: "Lobo-guará",
        scientificName: "Chrysocyon brachyurus",
        biome: 0,
        conservationStatus: "Vulnerável"
    )

    let animal2 = Animal(
        taxonID: 12346,
        commonName: "Tamanduá-bandeira",
        scientificName: "Myrmecophaga tridactyla",
        biome: 0,
        conservationStatus: "Vulnerável"
    )

    context.insert(animal1)
    context.insert(animal2)

    // Expedição 1: 2 desafios completos
    context.insert(Expedition(
        biome: 0,
        animal: animal1,
        overallRating: 3,
        challenge1Completed: true,
        challenge2Completed: false,
        challenge3Completed: true
    ))

    // Expedição 2: 1 desafio completo
    context.insert(Expedition(
        biome: 0,
        animal: animal2,
        overallRating: 2,
        challenge1Completed: true,
        challenge2Completed: false,
        challenge3Completed: false
    ))

    // 3 trues → 3 * 100 / 6 = 50%

    return container
}
