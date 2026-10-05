//
//  ExpeditionAnimalController.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine


@MainActor
final class ExpeditionAnimalController {
    enum State {
        case waiting, moving, movingToAction, acting, finished
    }

    let definition: ExpeditionAnimalDefinition
    let container: Entity
    let visualRoot: Entity
    let detectionRoot: Entity
    // O Entity real do USDZ que contém o esqueleto/AnimationResource.
    private let animationTarget: Entity
    private(set) var pose: ExpeditionAnimalPose = .idle
    
    private let waypoints: [SIMD3<Float>]
    private let actionPoints: [SIMD3<Float>]
    private let speed: Float
    private let loopRoute: Bool
    private let waitAtPosition: TimeInterval
    private let fallbackActionDuration: TimeInterval
    private let animationDurations: [String: TimeInterval]

    private var waypointIndex = 0
    private var currentTarget: SIMD3<Float>?
    private var waitRemaining: TimeInterval = 0
    private var actionRemaining: TimeInterval = 0
    private var arrivedWaypoints = 0
    private var state: State = .waiting
    private var currentAnimationKey = ""

    // --------------------------------------------------------
    // ESPELHAMENTO: eixo LOCAL do visualRoot que é a horizontal do sprite
    // --------------------------------------------------------
    // spriteHorizontalAxis: 0 = X, 1 = Y, 2 = Z (é o eixo que será invertido).
    // spriteRightLocal: vetor unitário (±eixo) que aponta para o X+ do mundo
    // (direita da tela) quando o sprite ainda não foi espelhado.
    // Calculado uma vez a partir de ExpeditionWorld.right, então continua valendo
    // mesmo que o container seja rotacionado no futuro (billboard).
    private let spriteHorizontalAxis: Int
    private let spriteRightLocal: SIMD3<Float>
    

    init(
        definition: ExpeditionAnimalDefinition,
        container: Entity,
        visualRoot: Entity,
        detectionRoot: Entity,
        animationTarget: Entity,
        waypoints: [SIMD3<Float>],
        actionPoints: [SIMD3<Float>],
        animationDurations: [String: TimeInterval]
    ) {
        // Onde fica o "direita do mundo" dentro do espaço local do sprite?
        let worldToLocal = visualRoot.orientation(relativeTo: nil).inverse
        let rightInLocal = worldToLocal.act(ExpeditionWorld.right)
        let ax = abs(rightInLocal.x)
        let ay = abs(rightInLocal.y)
        let az = abs(rightInLocal.z)
        let axis = (ax >= ay && ax >= az) ? 0 : (ay >= az ? 1 : 2)

        var unitRight = SIMD3<Float>(repeating: 0)
        unitRight[axis] = rightInLocal[axis] >= 0 ? 1 : -1

        self.spriteHorizontalAxis = axis
        self.spriteRightLocal = unitRight

        self.definition = definition
        self.container = container
        self.visualRoot = visualRoot
        self.detectionRoot = detectionRoot
        self.animationTarget = animationTarget
        self.waypoints = waypoints
        self.actionPoints = actionPoints
        self.speed = max(definition.speed, 0.01)
        self.loopRoute = definition.loopRoute
        self.waitAtPosition = max(0, definition.waitAtPosition)
        self.fallbackActionDuration = max(0, definition.actionDuration)
        self.animationDurations = animationDurations
       

        if let first = waypoints.first {
            container.position = first
            waitRemaining = waitAtPosition
        } else if let first = actionPoints.first {
            container.position = first
            waitRemaining = waitAtPosition
        } else {
            state = .finished
        }

        playAnimation(.idle)
    }

    // Chamado no encerramento da cena: para o movimento e as animações
    // para que o RealityKit não continue avaliando esse esqueleto.
    func shutdown() {
        state = .finished
        animationTarget.stopAllAnimations(recursive: true)
    }

    func update(deltaTime: TimeInterval, cameraRight: SIMD3<Float>) {
        guard state != .finished else { return }

        let dt = min(max(deltaTime, 0), 0.1)

        switch state {
        case .waiting:
            waitRemaining -= dt
            if waitRemaining <= 0 {
                beginNextBehavior()
            }

        case .moving, .movingToAction:
            guard let target = currentTarget else {
                beginNextBehavior()
                break
            }

            if moveToward(target: target, deltaTime: dt, cameraRight: cameraRight) {
                container.position = target
                currentTarget = nil

                if state == .moving {
                    arrivedWaypoints += 1
                    waitRemaining = waitAtPosition
                    state = .waiting
                    playAnimation(.idle)
                } else {
                    // Usa a duração real do trecho Action.
                    // actionDuration continua como fallback.
                    actionRemaining = animationDurations["action"] ?? fallbackActionDuration
                    state = .acting
                    playAnimation(.action)
                }
            }

        case .acting:
            actionRemaining -= dt
            if actionRemaining <= 0 {
                waitRemaining = waitAtPosition
                state = .waiting
                playAnimation(.idle)
            }

        case .finished:
            break
        }
    }

    private func beginNextBehavior() {
        guard !waypoints.isEmpty else {
            if let action = actionPoints.randomElement() {
                currentTarget = action
                state = .movingToAction
                playAnimation(.walking)
            } else {
                state = .finished
                playAnimation(.idle)
            }
            return
        }

        if shouldPerformAction(), !actionPoints.isEmpty {
            currentTarget = chooseActionPoint()
            state = .movingToAction
            playAnimation(.walking)
            return
        }

        let nextIndex: Int

        if waypointIndex + 1 < waypoints.count {
            nextIndex = waypointIndex + 1
        } else if loopRoute {
            nextIndex = 0
        } else {
            state = .finished
            playAnimation(.idle)
            return
        }

        waypointIndex = nextIndex
        currentTarget = waypoints[waypointIndex]
        state = .moving
        playAnimation(.walking)
    }

    private func shouldPerformAction() -> Bool {
        guard !actionPoints.isEmpty else { return false }

        if definition.randomActionEnabled {
            return Float.random(in: 0...1) <
                max(0, min(1, definition.randomActionChance))
        }

        let every = ExpeditionAnimalConfig.actionEveryWaypoints
        return every > 0 &&
            arrivedWaypoints > 0 &&
            arrivedWaypoints % every == 0
    }

    private func chooseActionPoint() -> SIMD3<Float> {
        if ExpeditionAnimalConfig.randomizeActionPoint {
            return actionPoints.randomElement() ?? actionPoints[0]
        }
        return actionPoints[0]
    }

    private func moveToward(
        target: SIMD3<Float>,
        deltaTime: TimeInterval,
        cameraRight: SIMD3<Float>
    ) -> Bool {
        let current = container.position
        let difference = target - current
        let distanceToTarget = simd_length(difference)

        if distanceToTarget <= 0.01 {
            return true
        }

        let direction = difference / distanceToTarget

        // Detecta esquerda/direita e espelha o modelo se necessário.
        updateFacing(from: difference, cameraRight: cameraRight)

        let step = speed * Float(deltaTime)

        if step >= distanceToTarget {
            return true
        }

        container.position = current + direction * step
        return false
    }

    // --------------------------------------------------------
    // ESPELHAMENTO HORIZONTAL
    // --------------------------------------------------------
    // Só é chamado enquanto o animal se move, então em idle/action
    // ele mantém o último lado para o qual estava virado.
    
    private func updateDetectionPosition(
        mirrored: Bool
    ) {

        var offset =
            definition.detectionOffset

        offset.x =
            abs(offset.x)

        if mirrored {

            offset.x *= -1
        }

        detectionRoot.position =
            offset
    }
    
    
    private func updateFacing(
        from difference: SIMD3<Float>,
        cameraRight: SIMD3<Float>
    ) {
        // Referência de "direita": X+ do mundo (ExpeditionWorld.right) ou a
        // horizontal real da câmera. A vertical do SEU mundo (eixo Z) é
        // removida dentro de ExpeditionWorld.screenHorizontal, então subidas e
        // descidas não invertem o animal.
        let referenceRight: SIMD3<Float>
        switch definition.movementAxis {
        case .x:
            referenceRight = ExpeditionWorld.right
        case .screen:
            referenceRight = cameraRight
        }

        let horizontal = ExpeditionWorld.screenHorizontal(
            of: difference,
            cameraRight: referenceRight
        )

        // Zona morta: indo/vindo em direção à câmera (eixo Y do seu mundo)
        // mantém o último lado, sem piscar.
        guard abs(horizontal) > ExpeditionWorld.horizontalDeadZone else { return }

        let movingRight = horizontal > 0
        let mirrored = movingRight != definition.modelFacesRight
        updateDetectionPosition(
            mirrored: mirrored
        )

        // Inverte só o eixo local que corresponde à horizontal do sprite,
        // preservando o tamanho original (abs) e o sinal da escala base.
        var scale = visualRoot.scale
        let magnitude = abs(scale[spriteHorizontalAxis])
        let baseSign = spriteRightLocal[spriteHorizontalAxis] >= 0 ? Float(1) : Float(-1)
        let target = (mirrored ? -baseSign : baseSign) * magnitude

        if scale[spriteHorizontalAxis] != target {
            scale[spriteHorizontalAxis] = target
            visualRoot.scale = scale
        }
    }

    private enum AnimationKind {
        case idle
        case walking
        case action
    }

    private func playAnimation(_ kind: AnimationKind) {
        let key: String
        let loops: Bool
        let resourceName: String

        switch kind { 
        case .idle:
            key = "idle";
            pose = .idle;
            loops = definition.idleLoops
            resourceName = "fauna_idle"
        case .walking:
            key = "walking";
            pose = .walking;
            loops = definition.walkingLoops
            resourceName = "fauna_walking"
        case .action:
            key = "action";
            pose = .action;
            loops = definition.actionLoops
            resourceName = "fauna_action"
        }

        guard key != currentAnimationKey else { return }

        guard let resource = findAnimation(named: resourceName) else {
            print("⚠️ Clip não encontrado: \(definition.displayName) → \(resourceName)")
            print("   Recursos disponíveis:")
            for entity in allEntities(in: visualRoot) {
                for animation in entity.availableAnimations {
                    print("   •", animation.name ?? "sem_nome")
                }
            }
            return
        }

        animationTarget.stopAllAnimations(recursive: true)

        // Para loop usamos o método oficial de repetição do RealityKit.
        // Para execução única usamos o resource sem repeat().
        let playableResource = loops
            ? resource.repeat(duration: .infinity)
            : resource

        animationTarget.playAnimation(
            playableResource,
            transitionDuration: 0.15,
            startsPaused: false
        )

        currentAnimationKey = key

        let duration = animationDurations[key] ?? resource.definition.duration
        print(
            "🎬 \(definition.displayName): \(key)",
            "• frames:", frameRangeDescription(for: key),
            "• duração:", String(format: "%.3fs", duration),
            "• loop:", loops
        )
    }

    private func findAnimation(named name: String) -> AnimationResource? {
        for entity in allEntities(in: visualRoot) {
            for animation in entity.availableAnimations {
                if animation.name == name {
                    return animation
                }
            }
        }
        return nil
    }

    private func frameRangeDescription(for key: String) -> String {
        switch key {
        case "idle":
            return "\(definition.idleStartFrame)-\(definition.idleEndFrame)"
        case "walking":
            return "\(definition.walkingStartFrame)-\(definition.walkingEndFrame)"
        case "action":
            return "\(definition.actionStartFrame)-\(definition.actionEndFrame)"
        default:
            return "?"
        }
    }

    private func allEntities(in root: Entity) -> [Entity] {
        var result = [root]
        for child in root.children {
            result.append(contentsOf: allEntities(in: child))
        }
        return result
    }
}
