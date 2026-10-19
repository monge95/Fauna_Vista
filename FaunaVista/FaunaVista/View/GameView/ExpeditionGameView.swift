//  ExpeditionGameView.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
 

import SwiftUI
import UIKit
import RealityKit
import Combine

// ============================================================
// MARK: - TELA DE JOGO
// ============================================================

struct ExpeditionGameView: View {
    var vm: ExpeditionViewState
    @State private var flashVisible = false
    @State private var debugAxis: ExpeditionDebugAxis = .x

    // HUDs de debug. Agora, quando `false`, eles NÃO ocupam espaço
    // (antes ficavam .hidden() mas consumiam altura e empurravam
    // contadores e botão da câmera para fora da tela no iPad).
    private let showDebugHUDs = false

    // Posição vertical do quadro de foto (fração da altura útil).
    // Ajuste se quiser subir/descer a mira.
    private let sightVerticalPosition: CGFloat = 0.42

    // Reservas para o quadro nunca invadir o topo (contadores) nem a câmera.
    private let topReserved: CGFloat = 72
    private let bottomReserved: CGFloat = 116

    private var sightTint: Color? {
        if vm.isVegetationDetected { return .gray }
        if vm.isTargetDetected { return .green }
        return nil
    }

    private let sightScale: CGFloat = 0.8
    private let sightOpacity: Double = 0.8

    @ViewBuilder
    private var sightImage: some View {
        if let tint = sightTint {
            Image("Sight")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(tint)
        } else {
            Image("Sight")
                .resizable()
                .scaledToFit()
        }
    }

    private var distanceText: String {
        guard let distance = vm.detectedObjectDistance else { return "--" }
        return String(format: "%.2f m", distance)
    }

    // MARK: - Debug (só aparecem com showDebugHUDs = true)

    private func aimTuneRow(title: String, y: CGFloat, atMaxZoom: Bool) -> some View {
        HStack(spacing: 6) {
            Text(title)
                .font(.caption2.monospaced())
                .foregroundStyle(.white)

            Button {
                vm.adjustAimOffset(atMaxZoom: atMaxZoom, deltaY: ExpeditionConfig.aimTuningStep)
            } label: {
                Image(systemName: "arrow.down.circle.fill").font(.system(size: 26))
            }

            Text("\(Int(y))")
                .font(.caption2.monospaced())
                .foregroundStyle(.white)
                .frame(minWidth: 34)

            Button {
                vm.adjustAimOffset(atMaxZoom: atMaxZoom, deltaY: -ExpeditionConfig.aimTuningStep)
            } label: {
                Image(systemName: "arrow.up.circle.fill").font(.system(size: 26))
            }
        }
    }

    private var aimTuningPanel: some View {
        VStack(spacing: 4) {
            Text("Ajuste da mira")
                .font(.caption2.monospaced())
                .foregroundStyle(.white.opacity(0.8))

            HStack(spacing: 14) {
                aimTuneRow(
                    title: "\(Int(ExpeditionConfig.minimumZoom))x",
                    y: vm.aimOffsetMinZoom.y,
                    atMaxZoom: false
                )
                aimTuneRow(
                    title: "\(Int(ExpeditionConfig.maximumZoom))x",
                    y: vm.aimOffsetMaxZoom.y,
                    atMaxZoom: true
                )
            }
        }
        .tint(.white)
        .padding(8)
        .background(.black.opacity(0.45), in: RoundedRectangle(cornerRadius: 12))
    }

    private var debugInfo: some View {
        VStack(spacing: 4) {
            HStack(spacing: 14) {
                Text("Objeto: \(vm.detectedObjectName)")
                Text("Distância: \(distanceText)")
            }
            .font(.caption.monospaced())
            .foregroundStyle(.white)

            HStack(spacing: 8) {
                Text("Avaliação:")
                    .font(.caption.monospaced())
                    .foregroundStyle(.white)

                if vm.isTargetDetected {
                    if vm.isDetectedObjectScorable {
                        Text(String(repeating: "⭐️", count: vm.detectedObjectStars))
                            .font(.caption)
                    } else {
                        Text("Sem avaliação")
                            .font(.caption.monospaced())
                            .foregroundStyle(.white.opacity(0.8))
                    }
                } else {
                    Text("--")
                        .font(.caption.monospaced())
                        .foregroundStyle(.white.opacity(0.8))
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(.black.opacity(0.45), in: Capsule())
        }
    }

    private var debugControls: some View {
        HStack(spacing: 16) {
            VStack(spacing: 6) {
                Picker("Eixo", selection: $debugAxis) {
                    ForEach(ExpeditionDebugAxis.allCases) { axis in
                        Text(axis.rawValue).tag(axis)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 130)

                HStack(spacing: 10) {
                    Button {
                        vm.debugMoveFocusedObject(axis: debugAxis, direction: -1)
                    } label: {
                        Image(systemName: "minus.circle.fill").font(.system(size: 34))
                    }

                    Text("Objeto")
                        .font(.caption2.monospaced())
                        .foregroundStyle(.white)

                    Button {
                        vm.debugMoveFocusedObject(axis: debugAxis, direction: 1)
                    } label: {
                        Image(systemName: "plus.circle.fill").font(.system(size: 34))
                    }
                }
            }
            .padding(8)
            .background(.black.opacity(0.45), in: RoundedRectangle(cornerRadius: 12))

            VStack(spacing: 6) {
                Button {
                    vm.debugMoveCamera(direction: 1)
                } label: {
                    Image(systemName: "arrow.up.circle.fill").font(.system(size: 34))
                }

                Text("Câmera")
                    .font(.caption2.monospaced())
                    .foregroundStyle(.white)

                Button {
                    vm.debugMoveCamera(direction: -1)
                } label: {
                    Image(systemName: "arrow.down.circle.fill").font(.system(size: 34))
                }
            }
            .padding(8)
            .background(.black.opacity(0.45), in: RoundedRectangle(cornerRadius: 12))
        }
        .tint(.white)
    }

    // MARK: - HUD fixo (contadores + câmera)

    private var topBar: some View {
        HStack {
            Label(
                "\(vm.photosTaken)/\(ExpeditionConfig.totalPhotos)",
                systemImage: "photo"
            )
            .padding(10)
            .background(.ultraThinMaterial, in: Capsule())

            Spacer(minLength: 8)

            Text("\(Int(ceil(max(0, vm.timeRemaining))))s")
                .monospacedDigit()
                .padding(10)
                .background(.ultraThinMaterial, in: Capsule())
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    private var cameraButton: some View {
        Button {
            vm.capturePhoto()
        } label: {
            Image(systemName: "camera.fill")
                .font(.system(size: 36, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 72, height: 72)
                .glassEffect(.regular, in: .circle)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 16)
    }

    // Quadro da foto (imagem "Sight")
    private func sightView(side: CGFloat) -> some View {
        sightImage
            .frame(width: side * sightScale, height: side * sightScale)
            .opacity(sightOpacity)
            .frame(width: side, height: side)
            .allowsHitTesting(false)
            .accessibilityHidden(true)
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(
                            key: CropRectKey.self,
                            value: geo.frame(in: .global)
                        )
                }
            )
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            ExpeditionSceneRepresentable(vm: vm)
                .ignoresSafeArea()

            // Tudo que é HUD fica dentro da área segura e se adapta ao tamanho real da tela
            GeometryReader { geo in
                let side = min(
                    ExpeditionConfig.photoCropSize,
                    min(geo.size.width, geo.size.height) * 0.8
                )
                let minY = side / 2 + topReserved
                let maxY = geo.size.height - side / 2 - bottomReserved
                let sightY = min(
                    max(geo.size.height * sightVerticalPosition, minY),
                    max(minY, maxY)
                )

                ZStack {
                    // Mira / quadro da foto
                    sightView(side: side)
                        .position(x: geo.size.width / 2, y: sightY)

                    // Topo e base presos nas bordas
                    VStack(spacing: 8) {
                        topBar

                        if showDebugHUDs && ExpeditionConfig.aimTuningPanelVisible {
                            aimTuningPanel
                        }

                        Spacer(minLength: 0)

                        if showDebugHUDs {
                            debugInfo
                            debugControls
                        }

                        cameraButton
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }

            // Flash da foto
            Color.black
                .opacity(flashVisible ? 1 : 0)
                .ignoresSafeArea()
                .allowsHitTesting(false)
                .accessibilityHidden(true)
        }
        .onChange(of: vm.photoFlashID) { _, _ in
            flashVisible = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                withAnimation(.easeOut(duration: 0.2)) {
                    flashVisible = false
                }
            }
        }
        .onPreferenceChange(CropRectKey.self) { rect in
            vm.updateCropRect(rect)
        }
    }
}
