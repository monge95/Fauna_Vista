//
//  ExpeditionSceneView.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine


final class ExpeditionSceneView: ARView {
    weak var vm: ExpeditionViewModel?

    // Ciclo de vida da cena.
    private var displayLinkProxy: ExpeditionDisplayLinkProxy?
    private var buildTask: Task<Void, Never>?
    private(set) var isTornDown = false

    private struct SceneObject {
        let target: ExpeditionSceneTarget

        // Entity que recebe o raycast.
        let entity: Entity

        // Entity que os controles de debug devem mover.
        let debugEntity: Entity
    }

    private let cameraEntity = Entity()
    private var sceneObjects: [SceneObject] = []
    private var animalControllers: [ExpeditionAnimalController] = []
    private let gestureDelegate = ExpeditionGestureDelegate()
    private var mapRoot: Entity?
    private let worldAnchor = AnchorEntity(world: .zero)
    private var cameraStartPosition = SIMD3<Float>.zero
    private var cameraFinalPosition = SIMD3<Float>.zero
    private var cameraStartOrientation = simd_quatf(angle: 0, axis: [0, 1, 0])
    private var cameraFinalOrientation = simd_quatf(angle: 0, axis: [0, 1, 0])
    private var cameraProgress: Float = 0
    private var cameraTravelDistance: Float = 0
    private var currentCameraTime: TimeInterval = 0
    private var cameraDebugVerticalOffset: Float = 0 // Deslocamento vertical aplicado pelos botões de debug da câmera.
    private weak var debugFocusedEntity: Entity? // Objeto atualmente sob a mira central (usado pelos controles de debug).
    private var yaw: Float = 0
    private var pitch: Float = 0
    private var zoom: Float = ExpeditionConfig.minimumZoom
    private var lastPanTranslation: CGPoint = .zero
    private var lastPinchScale: CGFloat = 1.0
    private var displayLink: CADisplayLink?
    private var foregroundObserver: NSObjectProtocol?
    private var lastDetectionRequestTime: CFTimeInterval = 0 //private var detectionTask: Task<Void, Never>?
    private let detectionInterval: CFTimeInterval = 1.0 / 20.0

    var mapLoaded = false

    var travelDistance: Float {
        cameraTravelDistance
    }

    var travelDuration: TimeInterval {
        guard cameraTravelDistance > 0 else { return 0 }
        return TimeInterval(
            cameraTravelDistance / max(ExpeditionConfig.cameraSpeed, 0.01)
        )
    }

    required init(frame: CGRect) {
        super.init(
            frame: frame,
            cameraMode: .nonAR,
            automaticallyConfigureSession: false
        )

        setupRealityKit()
        setupGestures()
        startRenderLoop()
        observeAppLifecycle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        cameraMode = .nonAR
        automaticallyConfigureSession = false
        setupRealityKit()
        setupGestures()
        startRenderLoop()
        observeAppLifecycle()
    }

    // Ponto da mira em coordenadas da própria view.
    // A mira desenhada pelo SwiftUI fica no centro do quadro da foto (cropRect),
    // que NÃO é o centro da view. O raycast precisa sair exatamente desse ponto.
    private var aimPoint: CGPoint {
        if let rect = vm?.cropRect, rect.width > 0, rect.height > 0 {
            return convert(CGPoint(x: rect.midX, y: rect.midY), from: nil)
        }
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }

    // Deslocamento manual da detecção no zoom atual (interpola 1x -> 5x). // esse ajuste foi necessario para realizar a calibragem em tempo real
    private func currentAimOffset() -> CGPoint {
        guard let vm else { return .zero }
        let range = ExpeditionConfig.maximumZoom - ExpeditionConfig.minimumZoom
        let t = range > 0
            ? CGFloat(max(0, min(1, (zoom - ExpeditionConfig.minimumZoom) / range)))
            : 0
        let a = vm.aimOffsetMinZoom
        let b = vm.aimOffsetMaxZoom
        return CGPoint(x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t)
    }

    // Ponto de tela de onde sai o raio: mira desenhada + ajuste manual.
    private var aimDetectionPoint: CGPoint {
        let base = aimPoint
        let o = currentAimOffset()
        return CGPoint(x: base.x + o.x, y: base.y + o.y)
    }

    private func publishAimOffset() {
        let o = currentAimOffset()
        guard let vm else { return }
        if abs(vm.aimDetectionOffset.x - o.x) > 0.01 || abs(vm.aimDetectionOffset.y - o.y) > 0.01 {
            vm.aimDetectionOffset = o
        }
    }

    // Raio calculado a partir da câmera REAL (posição, orientação e a escala
    // pixel/unidade medida com project), então já acompanha o zoom (FOV) atual.
    // Se project falhar, usa o ray(through:) do ARView.
    private func aimRay() -> (origin: SIMD3<Float>, direction: SIMD3<Float>)? {
        let point = aimDetectionPoint
        let origin = cameraEntity.position(relativeTo: nil)
        let orientation = cameraEntity.orientation(relativeTo: nil)
        let forward = orientation.act(SIMD3<Float>(0, 0, -1))
        let right = orientation.act(SIMD3<Float>(1, 0, 0))
        let up = orientation.act(SIMD3<Float>(0, 1, 0))
        let step: Float = 0.05

        if let c = project(origin + forward),
           let r = project(origin + forward + right * step),
           let u = project(origin + forward + up * step) {
            let fx = (r.x - c.x) / CGFloat(step)   // pixels por unidade, horizontal
            let fy = (c.y - u.y) / CGFloat(step)   // pixels por unidade, vertical
            if fx > 1, fy > 1 {
                let dx = Float((point.x - c.x) / fx)
                let dy = Float((c.y - point.y) / fy)
                return (origin, simd_normalize(forward + right * dx + up * dy))
            }
        }

        guard let fallback = ray(through: point) else { return nil }
        return (fallback.origin, simd_normalize(fallback.direction))
    }

    private func applyZoom() {
        let clampedZoom = max(
            ExpeditionConfig.minimumZoom,
            min(ExpeditionConfig.maximumZoom, zoom)
        )

        zoom = clampedZoom

        let fieldOfView =
            ExpeditionConfig.cameraFieldOfView / CGFloat(zoom)

        cameraEntity.components.set(
            PerspectiveCameraComponent(
                near: 0.01,
                far: 1500,
                fieldOfViewInDegrees: Float(fieldOfView)
            )
        )
    }

    private func setupRealityKit() {
        backgroundColor = UIColor(
            red: 0.55,
            green: 0.75,
            blue: 0.90,
            alpha: 1
        )

        cameraEntity.name = "ExpeditionCamera"
        cameraEntity.components.set(
            PerspectiveCameraComponent(
                near: 0.01,
                far: 1500,
                fieldOfViewInDegrees: Float(ExpeditionConfig.cameraFieldOfView)
            )
        )

        worldAnchor.addChild(cameraEntity)
        scene.addAnchor(worldAnchor)
        applyZoom()
    }

    private func playAnimations(in root: Entity) {
        for entity in allEntities(in: root) {
            for animation in entity.availableAnimations {
                entity.playAnimation(
                    animation.repeat(duration: .infinity),
                    transitionDuration: 0,
                    startsPaused: false
                )
            }
        }
    }

    private func loadBlenderMap() {
        buildTask?.cancel()
        buildTask = Task { @MainActor [weak self] in
            guard let self else { return }

            do {
                let loadedRoot = try await ExpeditionMapCache.shared.makeInstance()

                // A cena pode ter sido encerrada enquanto o mapa carregava.
                guard !Task.isCancelled, !self.isTornDown else { return }

                self.mapRoot = loadedRoot
                self.worldAnchor.addChild(loadedRoot)
                self.mapLoaded = true

                print("✅ Mapa do Blender carregado.")

                self.setupCameraMarkers(in: loadedRoot)
                self.playAnimations(in: loadedRoot)
                self.cameraProgress = 0
                self.currentCameraTime = 0
                self.yaw = 0
                self.pitch = 0
                self.cameraEntity.position = self.cameraStartPosition
                self.cameraEntity.orientation = self.cameraStartOrientation

                await self.createObjectsFromPositions(in: loadedRoot)
                guard !Task.isCancelled, !self.isTornDown else { return }

                await self.createAnimalsFromMarkers(in: loadedRoot)
                guard !Task.isCancelled, !self.isTornDown else { return }

                self.removeMetadataMarkers(in: loadedRoot)

                self.vm?.updateMapInformation()

                print("🗺️ Fauna Vista criado.")
                print("🐾 Objetos 3D detectáveis:", self.sceneObjects.count)
            } catch {
                print("❌ Erro ao carregar mapa:", error)
                self.mapLoaded = false
            }
        }
    }

    private func setupCameraMarkers(in root: Entity) {
        guard
            let startMarker = findEntity(named: "Camera_Inicio", in: root),
            let finalMarker = findEntity(named: "Camera_Final", in: root)
        else {
            print("❌ Camera_Inicio ou Camera_Final não encontrados.")

            cameraStartPosition = [0, 2.2, 0]
            cameraFinalPosition = [0, 2.2, -100]
            cameraTravelDistance = 100

            cameraEntity.position = cameraStartPosition
            cameraEntity.orientation = simd_quatf(angle: 0, axis: [0, 1, 0])
            return
        }

        cameraStartPosition = startMarker.position(relativeTo: nil)
        cameraFinalPosition = finalMarker.position(relativeTo: nil)
        cameraStartOrientation = startMarker.orientation(relativeTo: nil)
        cameraFinalOrientation = finalMarker.orientation(relativeTo: nil)

        cameraTravelDistance = distance(
            from: cameraStartPosition,
            to: cameraFinalPosition
        )

        cameraEntity.position = cameraStartPosition
        cameraEntity.orientation = cameraStartOrientation

        print("📍 Camera_Inicio:", cameraStartPosition)
        print("📍 Camera_Final:", cameraFinalPosition)
        print("📏 Distância:", cameraTravelDistance, "metros")
        print("⏱️ Duração:", travelDuration, "segundos")

        startMarker.removeFromParent()
        finalMarker.removeFromParent()
    }

    func buildExpedition() {
        guard !isTornDown else { return }

        resetExpedition()

        if !mapLoaded {
            loadBlenderMap()
            return
        }

        guard let mapRoot else { return }

        setupCameraMarkers(in: mapRoot)

        cameraProgress = 0
        currentCameraTime = 0
        yaw = 0
        pitch = 0

        cameraEntity.position = cameraStartPosition
        cameraEntity.orientation = cameraStartOrientation

        buildTask?.cancel()
        buildTask = Task { @MainActor [weak self, weak mapRoot] in
            guard let self, let mapRoot else { return }
            await self.createObjectsFromPositions(in: mapRoot)
            guard !Task.isCancelled, !self.isTornDown else { return }
            await self.createAnimalsFromMarkers(in: mapRoot)
            guard !Task.isCancelled, !self.isTornDown else { return }
            self.removeMetadataMarkers(in: mapRoot)
        }
    }

    private func findEntity(named name: String, in root: Entity) -> Entity? {
        if root.name == name {
            return root
        }

        for child in root.children {
            if let result = findEntity(named: name, in: child) {
                return result
            }
        }

        return nil
    }

    private func allEntities(in root: Entity) -> [Entity] {
        var result = [root]

        for child in root.children {
            result.append(contentsOf: allEntities(in: child))
        }

        return result
    }

    
    private func makeAnimalDetectionRectangle(
        animal: ExpeditionAnimalDefinition
    ) -> Entity {

        let parent = Entity()

        let thickness: Float = 0.05
        let width = animal.detectionScaleX
        let height = animal.detectionScaleY

        // Só cria as linhas visuais quando devem aparecer.
        if animal.detectionVisible {
            let material = SimpleMaterial(
                color: .blue,
                isMetallic: false
            )

            func line(
                size: SIMD3<Float>,
                position: SIMD3<Float>
            ) -> ModelEntity {
                let entity = ModelEntity(
                    mesh: .generateBox(size: size),
                    materials: [material]
                )

                entity.position = position
                return entity
            }

            let top = line(
                size: SIMD3<Float>(width, thickness, thickness),
                position: SIMD3<Float>(0, 0, height * 0.5)
            )

            let bottom = line(
                size: SIMD3<Float>(width, thickness, thickness),
                position: SIMD3<Float>(0, 0, -height * 0.5)
            )

            let left = line(
                size: SIMD3<Float>(thickness, thickness, height),
                position: SIMD3<Float>(-width * 0.5, 0, 0)
            )

            let right = line(
                size: SIMD3<Float>(thickness, thickness, height),
                position: SIMD3<Float>(width * 0.5, 0, 0)
            )

            parent.addChild(top)
            parent.addChild(bottom)
            parent.addChild(left)
            parent.addChild(right)
        }

        parent.position = animal.detectionOffset

        let shape = ShapeResource.generateBox(
            width: width,
            height: 0.25,
            depth: height
        )

        parent.components.set(
            CollisionComponent(shapes: [shape])
        )

        parent.components.set(
            AnimalDetectionTag()
        )

        return parent
    }

    
    private func createObjectsFromPositions(in root: Entity) async {
        let entities = allEntities(in: root)
        var created = 0

        for marker in entities {
            guard let objectType = ExpeditionObjectType.fromPositionName(marker.name) else {
                continue
            }

            // Fauna NÃO nasce aqui: os animais vêm de ExpeditionAnimalConfig
            // (createAnimalsFromMarkers), com rota e animação.
            // Antes, o objetoTeste1 ("Posicao_Animal_1") criava um tamanduá
            // estático extra. O marker é apagado depois, em removeMetadataMarkers.
            guard objectType.category == .vegetation else {
                continue
            }

            do {
                let objectRoot = try await ExpeditionObjectCache.shared.makeInstance(for: objectType)

                // Cena encerrada/reiniciada durante o carregamento: descarta.
                guard !Task.isCancelled, !isTornDown else { return }

                objectRoot.name = objectType.rawValue
                objectRoot.position = marker.position(relativeTo: nil)
                objectRoot.orientation = marker.orientation(relativeTo: nil)
                objectRoot.scale = marker.scale(relativeTo: nil)

                worldAnchor.addChild(objectRoot)

                let detectionEntity: Entity

                switch objectType.category {
                case .vegetation:
                    // A vegetação não usa mais as colisões do mesh original.
                    // O detector é uma caixa própria, estável e previsível.
                    removeCollisionComponents(from: objectRoot)

                    let vegetationDetection = makeVegetationDetectionRectangle(
                        for: objectRoot,
                        objectType: objectType
                    )

                    objectRoot.addChild(vegetationDetection)
                    detectionEntity = vegetationDetection

                case .fauna:
                    // Objetos de fauna continuam usando a colisão do próprio modelo.
                    await generateCollision(for: objectRoot, type: objectType)
                    detectionEntity = objectRoot
                }

                sceneObjects.append(
                    SceneObject(
                        target: .object(objectType),
                        entity: detectionEntity,
                        debugEntity: objectRoot
                    )
                )

                marker.removeFromParent()
                playAnimations(in: objectRoot)
                created += 1

                print(
                    "🐾 Objeto criado:",
                    objectType.modelName,
                    "em",
                    marker.name,
                    "• categoria:",
                    objectType.category
                )
            } catch {
                print(
                    "❌ Erro ao carregar",
                    objectType.modelName,
                    ":",
                    error
                )
            }
        }
        print("🐾 Total de objetos 3D criados:", created)
    }
    // Remove qualquer colisão antiga do modelo de vegetação.
    // Isso evita que um CollisionComponent residual faça o raycast
    // atingir o mesh antigo em vez do detector controlado.
    private func removeCollisionComponents(from root: Entity) {
        for entity in allEntities(in: root) {
            entity.components.remove(CollisionComponent.self)
        }
    }

    // Cria um detector baseado nos limites VISUAIS reais do modelo.
    // O detector acompanha o objeto porque é filho do próprio objectRoot.
    private func makeVegetationDetectionRectangle(
        for objectRoot: Entity,
        objectType: ExpeditionObjectType
    ) -> Entity {
        let parent = Entity()
        parent.name = "VegetationDetection_\(objectType.rawValue)"

        let bounds = objectRoot.visualBounds(relativeTo: objectRoot)
        let padding = max(ExpeditionConfig.vegetationDetectionPadding, 0)

        let width = max(bounds.extents.x + padding * 2, 0.05)
        let depth = max(bounds.extents.y + padding * 2, 0.05)
        let height = max(bounds.extents.z + padding * 2, 0.05)

        parent.position = bounds.center + ExpeditionConfig.vegetationDetectionOffset

        if ExpeditionConfig.vegetationDetectionVisible {
            addVegetationDebugBox(
                to: parent,
                width: width,
                depth: depth,
                height: height
            )
        }

        // RealityKit recebe as dimensões como X / Y / Z.
        // No mundo do FaunaVista, Z continua sendo o eixo vertical.
        let shape = ShapeResource.generateBox(
            width: width,
            height: depth,
            depth: height
        )

        parent.components.set(
            CollisionComponent(shapes: [shape])
        )

        parent.components.set(
            VegetationDetectionTag()
        )

        return parent
    }

    private func addVegetationDebugBox(
        to parent: Entity,
        width: Float,
        depth: Float,
        height: Float
    ) {
        let material = SimpleMaterial(
            color: .green,
            isMetallic: false
        )

        let thickness: Float = 0.025
        let halfX = width * 0.5
        let halfY = depth * 0.5
        let halfZ = height * 0.5

        func line(
            size: SIMD3<Float>,
            position: SIMD3<Float>
        ) -> ModelEntity {
            let entity = ModelEntity(
                mesh: .generateBox(size: size),
                materials: [material]
            )
            entity.position = position
            return entity
        }

        // 4 arestas no "teto" e 4 no "chão".
        for z in [-halfZ, halfZ] {
            parent.addChild(line(
                size: [width, thickness, thickness],
                position: [0, -halfY, z]
            ))
            parent.addChild(line(
                size: [width, thickness, thickness],
                position: [0, halfY, z]
            ))
            parent.addChild(line(
                size: [thickness, depth, thickness],
                position: [-halfX, 0, z]
            ))
            parent.addChild(line(
                size: [thickness, depth, thickness],
                position: [halfX, 0, z]
            ))
        }

        // 4 arestas verticais.
        for x in [-halfX, halfX] {
            for y in [-halfY, halfY] {
                parent.addChild(line(
                    size: [thickness, thickness, height],
                    position: [x, y, 0]
                ))
            }
        }
    }

    // ========================================================
    // MARK: - CRIAÇÃO DOS ANIMAIS A PARTIR DOS EMPTIES
    // ========================================================
    
        struct AnimalDetectionTag: Component {}
    struct VegetationDetectionTag: Component {}

    private func createAnimalsFromMarkers(in root: Entity) async {
        let entities = allEntities(in: root)

        for animal in ExpeditionAnimalConfig.animals where animal.enabled {
            let routeMarkers = entities.filter {
                isRouteMarker($0.name, for: animal)
            }

            let actionMarkers = entities.filter {
                isActionMarker($0.name, for: animal)
            }

            let sortedRouteMarkers = routeMarkers.sorted {
                routeMarkerNumber($0.name) < routeMarkerNumber($1.name)
            }

            let orderedRouteMarkers =
                ExpeditionAnimalConfig.randomizeRoute
                ? sortedRouteMarkers.shuffled()
                : sortedRouteMarkers

            let routePositions = orderedRouteMarkers.map {
                $0.position(relativeTo: nil)
            }

            let actionPositions = actionMarkers.map {
                $0.position(relativeTo: nil)
            }

            guard !routePositions.isEmpty || !actionPositions.isEmpty else {
                print(
                    "⚠️ Nenhuma posição para \(animal.displayName). " +
                    "Use pos1_\(animal.id), pos2_\(animal.id), " +
                    "posAction_\(animal.id)"
                )
                continue
            }

            do {
                let loadedAnimal = try await ExpeditionAnimalCache.shared.makeInstance(
                    for: animal
                )

                guard !Task.isCancelled, !isTornDown else { return }

                let container = Entity()
                container.name = "AnimalController_\(animal.id)"

                let visualRoot = Entity()
                visualRoot.name = "AnimalVisual_\(animal.id)"
                visualRoot.addChild(loadedAnimal)

                let detectionRectangle =
                    makeAnimalDetectionRectangle(
                        animal: animal
                    )

                container.addChild(
                    detectionRectangle
                )

                container.addChild(
                    visualRoot
                )

                // ----------------------------------------------------
                // UMA ANIMAÇÃO USDZ → 3 CLIPS
                // ----------------------------------------------------
                // tamandua_all.usdz contém toda a timeline:
                // 0...50    Idle
                // 51...100  Walking
                // 101...140 Action
                // Os três clips são criados com AnimationView.
                let animationDurations: [String: TimeInterval]
                do {
                    animationDurations = try await ExpeditionAnimalCache.shared.loadAnimationClips(
                        for: animal,
                        into: loadedAnimal
                    )
                } catch {
                    print(
                        "❌ Não foi possível separar as animações de \(animal.displayName):",
                        error.localizedDescription
                    )
                    continue
                }

                guard !Task.isCancelled, !isTornDown else { return }

                if let firstMarker = sortedRouteMarkers.first ?? actionMarkers.first {
                    container.position = firstMarker.position(relativeTo: nil)
                    container.scale = firstMarker.scale(relativeTo: nil)
                }

                worldAnchor.addChild(container)
              //  container.generateCollisionShapes(recursive: true)

                let controller = ExpeditionAnimalController(
                        definition: animal,
                        container: container,
                        visualRoot: visualRoot,
                        detectionRoot: detectionRectangle,
                        animationTarget: loadedAnimal,
                        waypoints: routePositions,
                        actionPoints: actionPositions,
                        animationDurations: animationDurations
                    )
               

                animalControllers.append(controller)

                sceneObjects.append(
                    SceneObject(
                        target: .animal(animal),
                        entity: detectionRectangle,
                        debugEntity: container
                    )
                )

                print(
                    "🐾 Animal 2D:",
                    animal.modelName,
                    "• posições:",
                    routePositions.count,
                    "• ações:",
                    actionPositions.count
                )
            } catch {
                print(
                    "❌ Erro ao carregar animal 2D",
                    animal.modelName,
                    ":",
                    error
                )
            }
        }
    }

    private func isRouteMarker(
        _ name: String,
        for animal: ExpeditionAnimalDefinition
    ) -> Bool {
        let normalized = normalizeMarkerName(name)
        guard normalized.hasPrefix("pos"),
              !normalized.hasPrefix("posaction")
        else { return false }

        let remainder = normalized.dropFirst(3)
        let digits = remainder.prefix { $0.isNumber }
        guard !digits.isEmpty else { return false }

        let suffix = String(remainder.dropFirst(digits.count))
            .trimmingCharacters(in: CharacterSet(charactersIn: "_"))

        return normalizeAnimalID(suffix) == normalizeAnimalID(animal.id)
    }

    private func isActionMarker(
        _ name: String,
        for animal: ExpeditionAnimalDefinition
    ) -> Bool {
        let normalized = normalizeMarkerName(name)
        guard normalized.hasPrefix("posaction") else { return false }

        let suffix = String(normalized.dropFirst("posaction".count))
            .trimmingCharacters(in: CharacterSet(charactersIn: "_"))

        return normalizeAnimalID(suffix) == normalizeAnimalID(animal.id)
    }

    private func routeMarkerNumber(_ name: String) -> Int {
        let normalized = normalizeMarkerName(name)
        guard normalized.hasPrefix("pos") else { return Int.max }

        let remainder = normalized.dropFirst(3)
        let digits = remainder.prefix { $0.isNumber }
        return Int(digits) ?? Int.max
    }

    private func normalizeMarkerName(_ name: String) -> String {
        name
            .folding(options: .diacriticInsensitive, locale: .current)
            .lowercased()
            .replacingOccurrences(of: " ", with: "_")
    }

    private func normalizeAnimalID(_ id: String) -> String {
        id.lowercased().replacingOccurrences(of: "_", with: "")
    }

    private func generateCollision(for objectRoot: Entity, type: ExpeditionObjectType) async {
        guard type.category == .fauna else { return }
        objectRoot.generateCollisionShapes(recursive: true)
    }

    private func removeMetadataMarkers(in root: Entity) {
        for entity in allEntities(in: root) {
            let name = entity.name.lowercased()

            if name == "camera_inicio" ||
                name == "camera_final" ||
                name.hasPrefix("posicao_animal_") ||
                name.hasPrefix("posaction") ||
                isAnyAnimalRouteMarker(name) {
                entity.removeFromParent()
            }
        }
    }

    private func isAnyAnimalRouteMarker(_ name: String) -> Bool {
        let normalized = normalizeMarkerName(name)
        guard normalized.hasPrefix("pos"),
              !normalized.hasPrefix("posaction")
        else { return false }

        let remainder = normalized.dropFirst(3)
        let digits = remainder.prefix { $0.isNumber }
        guard !digits.isEmpty else { return false }
        let suffix = String(remainder.dropFirst(digits.count))
            .trimmingCharacters(in: CharacterSet(charactersIn: "_"))
        return suffix.contains("animal")
    }

    private func distance(from a: SIMD3<Float>, to b: SIMD3<Float>) -> Float {
        simd_distance(a, b)
    }

    private func startRenderLoop() {
        displayLink?.invalidate()

        let proxy = ExpeditionDisplayLinkProxy(target: self)
        displayLinkProxy = proxy

        let link = CADisplayLink(
            target: proxy,
            selector: #selector(ExpeditionDisplayLinkProxy.step(_:))
        )
        link.add(to: .main, forMode: .common)
        displayLink = link
    }

    func updateFrame() {
        guard !isTornDown else { return }

        guard vm?.gameState == .playing else {
            updateAimTarget()
            return
        }
        let dt = Float(displayLink?.duration ?? (1.0 / 60.0))
        if cameraTravelDistance > 0 {
            currentCameraTime += TimeInterval(dt)

            let duration = max(travelDuration, 0.01)
            let progress = Float(
                min(
                    currentCameraTime / duration,
                    1.0
                )
            )
            cameraProgress = progress
            cameraEntity.position = interpolate(
                from: cameraStartPosition,
                to: cameraFinalPosition,
                progress: progress
            ) + SIMD3<Float>(0, cameraDebugVerticalOffset, 0)
            let automaticOrientation = simd_slerp(
                cameraStartOrientation,
                cameraFinalOrientation,
                progress
            )
            let userOrientation = simd_quatf(
                angle: yaw,
                axis: [0, 1, 0]
            ) * simd_quatf(
                angle: pitch,
                axis: [1, 0, 0]
            )
            cameraEntity.orientation = automaticOrientation * userOrientation
        }
        let cameraRight = cameraEntity.orientation(relativeTo: nil)
            .act(SIMD3<Float>(1, 0, 0))
        for animalController in animalControllers {
            animalController.update(
                deltaTime: TimeInterval(dt),
                cameraRight: cameraRight
            )
        }
        updateAimTarget()
    }
    // MARK: - DETECÇÃO DA MIRA CENTRAL
    private func updateAimTarget() {
        guard vm != nil, mapLoaded, !sceneObjects.isEmpty else {
            return
        }
        let now = CACurrentMediaTime()
        guard now - lastDetectionRequestTime >= detectionInterval else {
            return
        }
        lastDetectionRequestTime = now
        publishAimOffset()
        guard let cameraRay = aimRay() else {
            debugFocusedEntity = nil
            vm?.updateDetection(objectName: nil, distance: nil, stars: 0)
            return
        }
        let origin = cameraRay.origin
        let direction = simd_normalize(cameraRay.direction)
        let maxDistance = ExpeditionConfig.maxCaptureDistance + 1.0
        let hits = scene.raycast(
            origin: origin,
            direction: direction,
            length: maxDistance,
            query: .nearest,
            mask: .all,
            relativeTo: nil
        )
        guard
            let hit = hits.first,
            let target = sceneObject(containing: hit.entity)
        else {
            debugFocusedEntity = nil
            vm?.updateDetection(objectName: nil, distance: nil, stars: 0)
            return
        }
        // Guarda o objeto sob a mira para os controles de debug.
        debugFocusedEntity = target.debugEntity
        let cameraPosition = self.cameraEntity.position(relativeTo: nil)
        let realDistance = simd_distance(cameraPosition, hit.position)
        let hitDistance = self.effectiveDistance(real: realDistance)
        switch target.target {
        case .object(let objectType):
            switch objectType.category {
            case .vegetation:
                vm?.updateDetection(
                    objectName: objectType.displayName,
                    distance: hitDistance,
                    stars: 0,
                    isScorable: false,
                    isVegetation: true
                )
            case .fauna:
                guard hitDistance >= ExpeditionConfig.minimumCaptureDistance,
                      hitDistance <= ExpeditionConfig.maxCaptureDistance
                else {
                    vm?.updateDetection(
                        objectName: nil,
                        distance: hitDistance,
                        stars: 0
                    )
                    return
                }

                let stars = starsForDistance(hitDistance)

                vm?.updateDetection(
                    objectName: objectType.displayName,
                    distance: hitDistance,
                    stars: stars,
                    isScorable: true
                )
            }

        case .animal(let animal):
            guard hitDistance >= ExpeditionConfig.minimumCaptureDistance,
                  hitDistance <= ExpeditionConfig.maxCaptureDistance
            else {
                vm?.updateDetection(
                    objectName: nil,
                    distance: hitDistance,
                    stars: 0
                )
                return
            }

            let stars = starsForDistance(hitDistance)

            vm?.updateDetection(
                objectName: animal.displayName,
                distance: hitDistance,
                stars: stars,
                isScorable: true
            )
        }
    }

    private func sceneObject(
        containing hitEntity: Entity
    ) -> SceneObject? {

        var current: Entity? = hitEntity

        while let entity = current {

            if entity.components.has(AnimalDetectionTag.self) ||
                entity.components.has(VegetationDetectionTag.self) {
                return sceneObjects.first {
                    $0.entity === entity
                }
            }

            if let object = sceneObjects.first(
                where: {
                    $0.entity === entity
                }
            ) {
                return object
            }

            current = entity.parent
        }

        return nil
    }
    
    
    
    // Distância "aparente" considerando o zoom óptico da câmera.
    // Zoom maior = objeto parece mais perto = distância efetiva menor.
    private func effectiveDistance(real: Float) -> Float {
        real / max(zoom, 0.0001)
    }

    // ========================================================
    // MARK: - CONTROLES DE DEBUG
    // ========================================================

    // Move o objeto sob a mira ao longo do eixo escolhido (em metros).
    func debugMoveFocusedObject(axis: ExpeditionDebugAxis, delta: Float) {
        guard let entity = debugFocusedEntity else {
            print("🛠️ Debug: nenhum objeto em foco na mira para mover.")
            return
        }

        entity.position += axis.vector * delta

        let p = entity.position
        print(
            "🛠️ Debug: \(entity.name) movido em \(axis.rawValue) \(delta > 0 ? "+" : "")\(String(format: "%.2f", delta)) → posição (\(String(format: "%.2f", p.x)), \(String(format: "%.2f", p.y)), \(String(format: "%.2f", p.z)))"
        )
    }

    // Sobe ou desce a câmera (em metros), sem perder o deslocamento
    // quando a animação de viagem recalcula a posição a cada frame.
    func debugMoveCamera(verticalDelta: Float) {
        cameraDebugVerticalOffset += verticalDelta
        cameraEntity.position.y += verticalDelta

        print(
            "🛠️ Debug: câmera \(verticalDelta > 0 ? "subiu" : "desceu") \(String(format: "%.2f", abs(verticalDelta))) → altura \(String(format: "%.2f", cameraEntity.position.y))"
        )
    }
    
    
    private func starsForDistance(_ distance: Float) -> Int {
        let minimum = ExpeditionConfig.minimumDistanceForScore
        let maximum = ExpeditionConfig.maximumDistanceForScore

        guard maximum > minimum else { return 5 }

        let normalized = max(
            0,
            min(
                1,
                (distance - minimum) / (maximum - minimum)
            )
        )

        let score = Int(
            round(
                ExpeditionConfig.idealDistanceScore * (1 - normalized)
            )
        )

        switch score {
        case 0...20:
            return 1
        case 21...40:
            return 2
        case 41...60:
            return 3
        case 61...80:
            return 4
        default:
            return 5
        }
    }

    // ========================================================
    // MARK: - GESTOS
    // ========================================================

    private func setupGestures() {
        let pan = UIPanGestureRecognizer(
            target: self,
            action: #selector(handlePan)
        )
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 1
        pan.delegate = gestureDelegate
        addGestureRecognizer(pan)

        let pinch = UIPinchGestureRecognizer(
            target: self,
            action: #selector(handlePinch)
        )
        pinch.delegate = gestureDelegate
        addGestureRecognizer(pinch)
    }

    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .began {
            lastPinchScale = gesture.scale
            return
        }

        let currentScale = gesture.scale
        let delta = Float(currentScale / max(lastPinchScale, 0.0001))
        lastPinchScale = currentScale

        zoom *= delta
        zoom = max(
            ExpeditionConfig.minimumZoom,
            min(ExpeditionConfig.maximumZoom, zoom)
        )
        applyZoom()

        if gesture.state == .ended ||
            gesture.state == .cancelled ||
            gesture.state == .failed {
            lastPinchScale = 1.0
        }
    }

    /*func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }*/

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)

        let deltaX = translation.x - lastPanTranslation.x
        let deltaY = translation.y - lastPanTranslation.y

        lastPanTranslation = translation

        // Interpola a sensibilidade entre o zoom mínimo e o máximo.
        let zoomRange = ExpeditionConfig.maximumZoom - ExpeditionConfig.minimumZoom
        let t = zoomRange > 0
            ? max(0, min(1, (zoom - ExpeditionConfig.minimumZoom) / zoomRange))
            : 0
        let sensitivity = ExpeditionConfig.lookSensitivity
            + (ExpeditionConfig.lookSensitivityAtMaxZoom - ExpeditionConfig.lookSensitivity) * t

        yaw -= Float(deltaX) * sensitivity
        pitch -= Float(deltaY) * sensitivity
        pitch = max(-0.9, min(0.9, pitch))

        if gesture.state == .ended || gesture.state == .cancelled {
            lastPanTranslation = .zero
        }
    }


    // ========================================================
    // MARK: - FOTO
    // ========================================================

    func captureCurrentView(cropRect providedRect: CGRect) async -> CaptureResult {
        let screenshot = await snapshotImage()

        let cropSize = min(
            ExpeditionConfig.photoCropSize,
            min(bounds.width, bounds.height)
        )

        let fallback = CGRect(
            x: bounds.midX - cropSize / 2,
            y: bounds.midY - cropSize / 2,
            width: cropSize,
            height: cropSize
        )

        let localRect: CGRect

        if providedRect.width > 0 && providedRect.height > 0 {
            localRect = convert(providedRect, from: nil)
        } else {
            localRect = fallback
        }

        let finalCropRect = localRect.width > 0 && localRect.height > 0
            ? localRect
            : fallback

        let target = detectTargetAtAimPoint()

        let cropped = cropImage(
            screenshot,
            rect: finalCropRect
        )

        if let target {
            let stars = target.isScorable
                ? starsForDistance(target.distance)
                : 0

            return CaptureResult(
                image: cropped,
                stars: stars,
                objectName: target.object.target.displayName,
                distance: target.distance,
                isScorable: target.isScorable
            )
        }

        return CaptureResult(
            image: cropped,
            stars: 0,
            objectName: "Nenhum objeto detectado",
            distance: nil,
            isScorable: true
        )
    }

    private func detectTargetAtAimPoint() -> (object: SceneObject, distance: Float, isScorable: Bool)? {
        guard let cameraRay = aimRay() else {
            return nil
        }

        let origin = cameraRay.origin
        let direction = simd_normalize(cameraRay.direction)

        let hits = scene.raycast(
            origin: origin,
            direction: direction,
            length: ExpeditionConfig.maxCaptureDistance + 1.0,
            query: .nearest,
            mask: .all,
            relativeTo: nil
        )

        guard
            let hit = hits.first,
            let object = sceneObject(containing: hit.entity)
        else {
            return nil
        }

        let cameraPosition = cameraEntity.position(relativeTo: nil)
        let realDistance = simd_distance(cameraPosition, hit.position)
        let distance = effectiveDistance(real: realDistance)

        switch object.target {
        case .object(let objectType):
            switch objectType.category {
            case .vegetation:
                return (object, distance, false)

            case .fauna:
                guard distance >= ExpeditionConfig.minimumCaptureDistance,
                      distance <= ExpeditionConfig.maxCaptureDistance
                else {
                    return nil
                }
                return (object, distance, true)
            }

        case .animal:
            guard distance >= ExpeditionConfig.minimumCaptureDistance,
                  distance <= ExpeditionConfig.maxCaptureDistance
            else {
                return nil
            }
            return (object, distance, true)
        }
    }

    private func snapshotImage() async -> UIImage {
        guard !isTornDown else { return renderFallbackImage() }

        return await withCheckedContinuation { continuation in
            snapshot(saveToHDR: false) { image in
                continuation.resume(
                    returning: image ?? self.renderFallbackImage()
                )
            }
        }
    }

    private func renderFallbackImage() -> UIImage {
        UIGraphicsImageRenderer(size: bounds.size).image { context in
            layer.render(in: context.cgContext)
        }
    }

    private func cropImage(
        _ image: UIImage,
        rect: CGRect
    ) -> UIImage {
        guard let cgImage = image.cgImage else {
            return image
        }

        let scaleX = CGFloat(cgImage.width) / max(bounds.width, 1)
        let scaleY = CGFloat(cgImage.height) / max(bounds.height, 1)

        let pixelRect = CGRect(
            x: rect.origin.x * scaleX,
            y: rect.origin.y * scaleY,
            width: rect.width * scaleX,
            height: rect.height * scaleY
        ).integral

        let imageBounds = CGRect(
            x: 0,
            y: 0,
            width: cgImage.width,
            height: cgImage.height
        )

        let safeRect = pixelRect.intersection(imageBounds)

        guard
            safeRect.width > 0,
            safeRect.height > 0,
            let cropped = cgImage.cropping(to: safeRect)
        else {
            return image
        }

        return UIImage(
            cgImage: cropped,
            scale: image.scale,
            orientation: image.imageOrientation
        )
    }

    // ========================================================
    // MARK: - UTILITÁRIOS
    // ========================================================

    private func interpolate(
        from: SIMD3<Float>,
        to: SIMD3<Float>,
        progress: Float
    ) -> SIMD3<Float> {
        simd_mix(from, to, SIMD3<Float>(repeating: progress))
    }

    func resetExpedition() {
        // Cancela qualquer carregamento em andamento: sem isso, uma Task
        // antiga terminaria depois e adicionaria objetos duplicados à cena.
        buildTask?.cancel()
        buildTask = nil

        lastDetectionRequestTime = 0

        for controller in animalControllers {
            controller.shutdown()
        }
        animalControllers.removeAll()

        // ATENÇÃO: `entity` é só a caixa de detecção (filha). Quem está
        // pendurado no worldAnchor é o `debugEntity` (o root do modelo).
        // Remover apenas `entity` deixava vegetação e animais na cena,
        // animando, e eles se acumulavam a cada nova partida.
        for sceneObject in sceneObjects {
            stopAnimationsRecursively(in: sceneObject.debugEntity)
            sceneObject.entity.removeFromParent()
            sceneObject.debugEntity.removeFromParent()
        }
        sceneObjects.removeAll()
        debugFocusedEntity = nil

        if let mapRoot {
            stopAnimationsRecursively(in: mapRoot)
        }

        cameraProgress = 0
        currentCameraTime = 0
        yaw = 0
        pitch = 0
        zoom = ExpeditionConfig.minimumZoom
        applyZoom()
        lastPanTranslation = .zero
        lastPinchScale = 1.0
        mapLoaded = false
        cameraTravelDistance = 0

        mapRoot?.removeFromParent()
        mapRoot = nil

        vm?.updateDetection(
            objectName: nil,
            distance: nil,
            stars: 0
        )
    }

    private func stopAnimationsRecursively(in root: Entity) {
        root.stopAllAnimations(recursive: true)
    }

    // ========================================================
    // MARK: - ENCERRAMENTO DA CENA
    // ========================================================
    // Desmonta TUDO que mantém a cena viva. É idempotente (pode ser chamado
    // mais de uma vez) e deve ser chamado ao fim da partida e também quando
    // o SwiftUI destrói a view (dismantleUIView).
    // Depois disso esta instância não deve mais ser usada: uma nova partida
    // cria uma nova ExpeditionSceneView.
    func teardown() {
        guard !isTornDown else { return }
        isTornDown = true

        // 1) Para o que roda sozinho.
        displayLink?.invalidate()
        displayLink = nil
        displayLinkProxy = nil

        if let foregroundObserver {
            NotificationCenter.default.removeObserver(foregroundObserver)
            self.foregroundObserver = nil
        }

        buildTask?.cancel()
        buildTask = nil

        // 2) Para animações e movimento.
        for controller in animalControllers {
            controller.shutdown()
        }
        animalControllers.removeAll()
        stopAnimationsRecursively(in: worldAnchor)

        // 3) Solta as entidades e a cena.
        for sceneObject in sceneObjects {
            sceneObject.entity.removeFromParent()
            sceneObject.debugEntity.removeFromParent()
        }
        sceneObjects.removeAll()
        debugFocusedEntity = nil

        mapRoot?.removeFromParent()
        mapRoot = nil
        mapLoaded = false

        cameraEntity.removeFromParent()
        worldAnchor.children.removeAll()
        scene.anchors.removeAll()

        // 4) Remove gestos (cada um guarda target = self).
        gestureRecognizers?.forEach { removeGestureRecognizer($0) }

        // 5) Avisa o ViewModel para soltar a referência a esta view.
        let owner = vm
        vm = nil
        owner?.sceneViewDidTearDown(self)
    }

    private func refreshAfterForeground() {
        guard !isTornDown else { return }
        setNeedsDisplay()
    }

    private func observeAppLifecycle() {
        foregroundObserver =
            NotificationCenter.default.addObserver(
                forName: UIApplication.didBecomeActiveNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                self?.refreshAfterForeground()
            }
    }

    deinit {
       // detectionTask?.cancel()
        displayLink?.invalidate()

        if let foregroundObserver {
            NotificationCenter.default.removeObserver(
                foregroundObserver
            )
        }
    }
}
