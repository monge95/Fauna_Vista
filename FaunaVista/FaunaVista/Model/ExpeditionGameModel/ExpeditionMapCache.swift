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


@MainActor
final class ExpeditionMapCache {
    static let shared = ExpeditionMapCache()
    private var templates: [String: Entity] = [:]
    private var tasks: [String: Task<Entity, Error>] = [:]
    private init() {}

    func preload(fileName: String) {
        // Descarta mapas de outras fases.
        templates = templates.filter { $0.key == fileName }
        tasks = tasks.filter { $0.key == fileName }

        guard templates[fileName] == nil, tasks[fileName] == nil else { return }
        tasks[fileName] = Task { try await self.loadFromDisk(fileName) }
    }

    func makeInstance(fileName: String) async throws -> Entity {
        if let t = templates[fileName] { return t.clone(recursive: true) }
        if let task = tasks[fileName] {
            return try await task.value.clone(recursive: true)
        }
        return try await loadFromDisk(fileName).clone(recursive: true)
    }

    private func loadFromDisk(_ fileName: String) async throws -> Entity {
        guard let url = Bundle.main.url(
            forResource: fileName,
            withExtension: ExpeditionConfig.mapFileExtension
        ) else {
            throw NSError(domain: "ExpeditionMapCache", code: 1,
                          userInfo: [NSLocalizedDescriptionKey:
                                        "Não encontrei \(fileName).\(ExpeditionConfig.mapFileExtension) no bundle."])
        }
        let entity = try await Entity(contentsOf: url)
        templates[fileName] = entity
        tasks[fileName] = nil
        return entity
    }
}
