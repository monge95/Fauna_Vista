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


@MainActor
final class ExpeditionObjectCache {
    static let shared = ExpeditionObjectCache()
    private var cache: [String: Entity] = [:]
    private var tasks: [String: Task<Entity, Error>] = [:]
    private init() {}

    func preload(modelNames: [String]) {
        for name in Set(modelNames) { preload(name) }
    }

    private func preload(_ name: String) {
        guard cache[name] == nil, tasks[name] == nil else { return }
        tasks[name] = Task { try await loadFromDisk(name) }
    }

    func makeInstance(modelName: String) async throws -> Entity {
        if let cached = cache[modelName] { return cached.clone(recursive: true) }
        if let task = tasks[modelName] {
            return try await task.value.clone(recursive: true)
        }
        return try await loadFromDisk(modelName).clone(recursive: true)
    }

    private func loadFromDisk(_ name: String) async throws -> Entity {
        guard let url = Bundle.main.url(forResource: name, withExtension: "usdz") else {
            throw NSError(domain: "ExpeditionObjectCache", code: 1,
                          userInfo: [NSLocalizedDescriptionKey:
                                        "Não encontrei \(name).usdz no bundle."])
        }
        let entity = try await Entity(contentsOf: url)
        cache[name] = entity
        tasks[name] = nil
        return entity
    }
}
