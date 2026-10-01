//
//  ExpeditionObjectCache.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine


// MARK: - CACHE DOS OBJETOS 3D
@MainActor
final class ExpeditionObjectCache {
    static let shared = ExpeditionObjectCache()
    private var cache: [ExpeditionObjectType: Entity] = [:]
    private var tasks: [ExpeditionObjectType: Task<Entity, Error>] = [:]
    
    private init() {}
    func preloadAll() {
        for objectType in ExpeditionObjectType.allCases {
            preload(objectType)
        }
    }

    private func preload(_ objectType: ExpeditionObjectType) {
        guard cache[objectType] == nil, tasks[objectType] == nil else { return }

        tasks[objectType] = Task {
            try await loadFromDisk(objectType)
        }
    }

    func makeInstance(for objectType: ExpeditionObjectType) async throws -> Entity {
        if let cached = cache[objectType] {
            return cached.clone(recursive: true)
        }

        if let task = tasks[objectType] {
            let entity = try await task.value
            return entity.clone(recursive: true)
        }

        let entity = try await loadFromDisk(objectType)
        return entity.clone(recursive: true)
    }

    private func loadFromDisk(_ objectType: ExpeditionObjectType) async throws -> Entity {
        guard let url = Bundle.main.url(
            forResource: objectType.modelName,
            withExtension: "usdz"
        ) else {
            throw NSError(
                domain: "ExpeditionObjectCache",
                code: 1,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        "Não encontrei \(objectType.modelName).usdz no bundle."
                ]
            )
        }

        let entity = try await Entity(contentsOf: url)
        cache[objectType] = entity
        tasks[objectType] = nil
        return entity
    }
}
