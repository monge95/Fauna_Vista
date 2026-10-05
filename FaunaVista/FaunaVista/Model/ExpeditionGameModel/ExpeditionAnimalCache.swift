//
//  ExpeditionAnimalCache.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine


@MainActor
final class ExpeditionAnimalCache {
    static let shared = ExpeditionAnimalCache()
    private var cache: [String: Entity] = [:]
    private var tasks: [String: Task<Entity, Error>] = [:]
    private init() {}
    func preloadAll() {
        for animal in ExpeditionAnimalConfig.animals where animal.enabled {
            preload(animal)
        }
    }
     func preload(_ animal: ExpeditionAnimalDefinition) {
        guard cache[animal.id] == nil, tasks[animal.id] == nil else { return }
        tasks[animal.id] = Task {
            try await loadFromDisk(animal)
        }
    }
    func makeInstance(for animal: ExpeditionAnimalDefinition) async throws -> Entity {
        if let cached = cache[animal.id] {
            return cached.clone(recursive: true)
        }
        if let task = tasks[animal.id] {
            let entity = try await task.value
            return entity.clone(recursive: true)
        }
        let entity = try await loadFromDisk(animal)
        return entity.clone(recursive: true)
    }
    // UMA ANIMAÇÃO USDZ -> 3 CLIPS DE ANIMAÇÃO
    // RealityKit permite criar uma AnimationView a partir da definição
    // da animação importada e limitar o trecho com trimStart/trimEnd.
    // Os trims são em segundos; aqui convertemos os frames do Blender
    // usando a duração real que RealityKit encontrou no USDZ.
    func loadAnimationClips(
        for animal: ExpeditionAnimalDefinition,
        into animationTarget: Entity
    ) async throws -> [String: TimeInterval] {
        let animations = allAnimations(in: animationTarget)
        guard let sourceAnimation = animations.first else {
            throw NSError(
                domain: "ExpeditionAnimalCache",
                code: 3,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        "O arquivo \(animal.modelName).usdz foi carregado, mas nenhuma animação foi encontrada."
                ]
            )
        }
        let definition = sourceAnimation.definition
        let totalDuration = max(definition.duration, 0.0001)
        let totalFrameSpan = max(
            1,
            animal.animationTimelineEndFrame - animal.animationTimelineStartFrame
        )
        func seconds(for frame: Int) -> TimeInterval {
            let clampedFrame = min(
                max(frame, animal.animationTimelineStartFrame),
                animal.animationTimelineEndFrame
            )
            let relativeFrame = clampedFrame - animal.animationTimelineStartFrame
            return totalDuration *
                TimeInterval(relativeFrame) /
                TimeInterval(totalFrameSpan)
        }

        func makeClip(
            name: String,
            startFrame: Int,
            endFrame: Int
        ) throws -> (AnimationResource, TimeInterval) {
            let start = seconds(for: startFrame)
            let end = max(start + 0.0001, seconds(for: endFrame))

            let view = AnimationView(
                source: definition,
                name: name,
                bindTarget: definition.bindTarget,
                blendLayer: definition.blendLayer,
                repeatMode: definition.repeatMode,
                fillMode: definition.fillMode,
                trimStart: start,
                trimEnd: end,
                trimDuration: nil,
                offset: 0,
                delay: 0,
                speed: definition.speed
            )

            let resource = try AnimationResource.generate(with: view)
            return (resource, end - start)
        }
        let idle = try makeClip(
            name: "fauna_idle",
            startFrame: animal.idleStartFrame,
            endFrame: animal.idleEndFrame
        )
        let walking = try makeClip(
            name: "fauna_walking",
            startFrame: animal.walkingStartFrame,
            endFrame: animal.walkingEndFrame
        )
        let action = try makeClip(
            name: "fauna_action",
            startFrame: animal.actionStartFrame,
            endFrame: animal.actionEndFrame
        )
        idle.0.store(in: animationTarget)   // Os clips são armazenados no mesmo Entity que possui o esqueleto.
        walking.0.store(in: animationTarget)
        action.0.store(in: animationTarget)
        print("🎬 \(animal.displayName): animação única encontrada → \(sourceAnimation.name ?? "sem_nome")")
        print("   ⏱️ Duração importada: \(String(format: "%.3f", totalDuration))s")
        print("   💤 Idle: frames \(animal.idleStartFrame)-\(animal.idleEndFrame) → \(String(format: "%.3f", idle.1))s")
        print("   🚶 Walking: frames \(animal.walkingStartFrame)-\(animal.walkingEndFrame) → \(String(format: "%.3f", walking.1))s")
        print("   🐾 Action: frames \(animal.actionStartFrame)-\(animal.actionEndFrame) → \(String(format: "%.3f", action.1))s")
        return [
            "idle": idle.1,
            "walking": walking.1,
            "action": action.1
        ]
    }

    private func allAnimations(in root: Entity) -> [AnimationResource] {
        var result: [AnimationResource] = []

        for entity in allEntities(in: root) {
            result.append(contentsOf: entity.availableAnimations)
        }

        return result
    }

    private func loadFromDisk(_ animal: ExpeditionAnimalDefinition) async throws -> Entity {
        guard let url = Bundle.main.url(
            forResource: animal.modelName,
            withExtension: "usdz"
        ) else {
            throw NSError(
                domain: "ExpeditionAnimalCache",
                code: 1,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        "Não encontrei \(animal.modelName).usdz no bundle."
                ]
            )
        }
        let entity = try await Entity(contentsOf: url)
        cache[animal.id] = entity
        tasks[animal.id] = nil
        return entity
    }
    private func allEntities(in root: Entity) -> [Entity] {
        var result = [root]
        for child in root.children {
            result.append(contentsOf: allEntities(in: child))
        }
        return result
    }
}
