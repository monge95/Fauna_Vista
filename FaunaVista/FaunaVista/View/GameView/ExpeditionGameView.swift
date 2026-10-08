//
//  ExpeditionGameView.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

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

    private var aimColor: Color {
        if vm.isVegetationDetected {
            return .gray
        }

        if vm.isTargetDetected {
            return .green
        }

        return .white
    }

    private var distanceText: String {
        guard let distance = vm.detectedObjectDistance else {
            return "--"
        }

        return String(format: "%.2f m", distance)
    }

    // Ajuste ao vivo da altura da detecção em cada extremo do zoom.
    // Seta para cima = detecção sobe (y negativo).
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
        .background(
            .black.opacity(0.45),
            in: RoundedRectangle(cornerRadius: 12)
        )
    }

    var body: some View {
        ZStack {
            ExpeditionSceneRepresentable(vm: vm)
                .ignoresSafeArea()

            VStack {
                HStack {
                    Label(
                        "\(vm.photosTaken)/\(ExpeditionConfig.totalPhotos)",
                        systemImage: "photo"
                    )
                    .padding(10)
                    .background(
                        .ultraThinMaterial,
                        in: Capsule()
                    )

                    Spacer()

                    Text(
                        "\(Int(ceil(max(0, vm.timeRemaining))))s"
                    )
                    .monospacedDigit()
                    .padding(10)
                    .background(
                        .ultraThinMaterial,
                        in: Capsule()
                    )
                }
                .padding()

                if ExpeditionConfig.aimTuningPanelVisible {
                    aimTuningPanel
                }

                Spacer()

                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(
                            .white.opacity(0.8),
                            lineWidth: 2
                        )
                        .frame(
                            width: ExpeditionConfig.photoCropSize,
                            height: ExpeditionConfig.photoCropSize
                        )
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .preference(
                                        key: CropRectKey.self,
                                        value: geo.frame(in: .global)
                                    )
                            }
                        )

                    Circle()
                        .fill(aimColor)
                        .frame(
                            width: ExpeditionConfig.aimPointRadius * 2,
                            height: ExpeditionConfig.aimPointRadius * 2
                        )
                        .overlay {
                            Circle()
                                .stroke(.black.opacity(0.35), lineWidth: 1)
                        }
                        .shadow(
                            color: .black.opacity(0.45),
                            radius: 3
                        )

                    // Ponto REAL de onde sai a detecção (mira + ajuste manual).
                    if ExpeditionConfig.aimDebugMarkerVisible {
                        Circle()
                            .stroke(.cyan, lineWidth: 2)
                            .frame(width: 14, height: 14)
                            .offset(
                                x: vm.aimDetectionOffset.x,
                                y: vm.aimDetectionOffset.y
                            )
                            .allowsHitTesting(false)
                    }
                }

                Spacer()

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
                    .background(
                        .black.opacity(0.45),
                        in: Capsule()
                    )
                }
                .padding(.bottom, 10)

                // ==================================================
                // CONTROLES DE DEBUG
                // Ficam abaixo do quadro da foto, sem sobrepor a mira.
                // ==================================================
                HStack(spacing: 16) {
                    // Move o objeto em foco no eixo escolhido.
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
                                vm.debugMoveFocusedObject(
                                    axis: debugAxis,
                                    direction: -1
                                )
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .font(.system(size: 34))
                            }

                            Text("Objeto")
                                .font(.caption2.monospaced())
                                .foregroundStyle(.white)

                            Button {
                                vm.debugMoveFocusedObject(
                                    axis: debugAxis,
                                    direction: 1
                                )
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 34))
                            }
                        }
                    }
                    .padding(8)
                    .background(
                        .black.opacity(0.45),
                        in: RoundedRectangle(cornerRadius: 12)
                    )

                    // Sobe ou desce a câmera.
                    VStack(spacing: 6) {
                        Button {
                            vm.debugMoveCamera(direction: 1)
                        } label: {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.system(size: 34))
                        }

                        Text("Câmera")
                            .font(.caption2.monospaced())
                            .foregroundStyle(.white)

                        Button {
                            vm.debugMoveCamera(direction: -1)
                        } label: {
                            Image(systemName: "arrow.down.circle.fill")
                                .font(.system(size: 34))
                        }
                    }
                    .padding(8)
                    .background(
                        .black.opacity(0.45),
                        in: RoundedRectangle(cornerRadius: 12)
                    )
                }
                .tint(.white)
                .padding(.bottom, 8)

                HStack {
                    Spacer()

                    Button {
                        vm.capturePhoto()
                    } label: {
                        Image(systemName: "camera.circle.fill")
                            .font(.system(size: 72))
                            .symbolRenderingMode(.hierarchical)
                    }

                    Spacer()
                }
                .padding(.bottom, 24)
            }

            // Fica por cima da cena e dos controles, sem entrar na foto:
            // captureCurrentView faz o snapshot apenas do ARView abaixo.
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
