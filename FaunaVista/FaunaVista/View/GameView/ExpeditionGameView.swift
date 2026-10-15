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
    @State private var showExitConfirmation = false

    // HUDs de debug/ajuda (painel de ajuste da mira, objeto/distância/avaliação
    // e controles de objeto/câmera). Ficam OCULTOS, mas continuam ocupando o mesmo
    // espaço no layout (.hidden()), para o quadro da foto não sair da posição
    // em que foi calibrado. Mude para `true` se precisar calibrar de novo.
    private let showDebugHUDs = false

    // Cor aplicada na imagem "Sight". nil = imagem com suas cores originais.
    private var sightTint: Color? {
        if vm.isVegetationDetected {
            return .gray
        }

        if vm.isTargetDetected {
            return .green
        }

        return nil
    }

    // A imagem fica 20% menor e 20% mais transparente.
    // O quadro de medição (photoCropSize) NÃO muda, então o recorte da foto
    // e o ponto de detecção continuam exatamente no mesmo lugar.
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
                    // Botão de sair da expedição
                    Button {
                        showExitConfirmation = true
                    } label: {
                        Image(systemName: "figure.walk.arrival")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.primary)
                            .frame(width: 40, height: 40)
                            .background(
                                .ultraThinMaterial,
                                in: Circle()
                            )
                    }
                    .accessibilityLabel("Sair da expedição")

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
                        .hiddenKeepingLayout(!showDebugHUDs)
                }

                Spacer()

                // Moldura da foto = imagem "Sight". Muda de cor quando detecta.
                // A bolinha central foi removida; a detecção continua saindo
                // do centro do quadro (cropRect) + ajuste de calibração.
                sightImage
                    .frame(
                        width: ExpeditionConfig.photoCropSize * sightScale,
                        height: ExpeditionConfig.photoCropSize * sightScale
                    )
                    .opacity(sightOpacity)
                    .frame(
                        width: ExpeditionConfig.photoCropSize,
                        height: ExpeditionConfig.photoCropSize
                    )
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
                .hiddenKeepingLayout(!showDebugHUDs)

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
                .hiddenKeepingLayout(!showDebugHUDs)

                HStack {
                    Spacer()

                    Button {
                        vm.capturePhoto()
                    } label: {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 36, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 72, height: 72)
                            .glassEffect(.regular, in: .circle)
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
        .alert(
            "Sair da expedição?",
            isPresented: $showExitConfirmation
        ) {
            Button("Continuar", role: .cancel) { }

            Button("Sair", role: .destructive) {
                vm.cancelExpedition()
            }
        } message: {
            Text("Você perderá o progresso e as fotos tiradas nesta expedição.")
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


// Esconde a view mas mantém o espaço que ela ocupa no layout.
private extension View {
    @ViewBuilder
    func hiddenKeepingLayout(_ hide: Bool) -> some View {
        if hide {
            self.hidden()
        } else {
            self
        }
    }
}
