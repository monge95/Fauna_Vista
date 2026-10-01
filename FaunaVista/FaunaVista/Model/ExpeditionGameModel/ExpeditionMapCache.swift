//
//  ExpeditionMapCache.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine


// MARK: - CACHE DO MAPA
@MainActor
final class ExpeditionMapCache {
    static let shared = ExpeditionMapCache()
    private var templateEntity: Entity?
    private var loadingTask: Task<Entity, Error>?
    private init() {}

    func preload() {
        guard templateEntity == nil, loadingTask == nil else { return }
        loadingTask = Task {
            try await self.loadFromDisk()
        }
    }

    func makeInstance() async throws -> Entity {
        if let templateEntity {
            return templateEntity.clone(recursive: true)
        }
        if let loadingTask {
            let entity = try await loadingTask.value
            return entity.clone(recursive: true)
        }
        let entity = try await loadFromDisk()
        return entity.clone(recursive: true)
    }
    private func loadFromDisk() async throws -> Entity {
        guard let url = Bundle.main.url(
            forResource: ExpeditionConfig.mapFileName,
            withExtension: ExpeditionConfig.mapFileExtension
        ) else {
            throw NSError(
                domain: "ExpeditionMapCache",
                code: 1,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        "Não encontrei \(ExpeditionConfig.mapFileName).\(ExpeditionConfig.mapFileExtension) no bundle."
                ]
            )
        }
        let entity = try await Entity(contentsOf: url)
        templateEntity = entity
        loadingTask = nil
        return entity
    }
}
