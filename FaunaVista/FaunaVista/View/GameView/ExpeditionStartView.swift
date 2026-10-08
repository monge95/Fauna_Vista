//
//  ExpeditionStartView.swift
//

import SwiftUI

// MARK: - TELA INICIAL (onboarding da expedição)
struct ExpeditionStartView: View {
    var vm: ExpeditionViewState

    var body: some View {
        ZStack {
            FaunaPalette.beige.ignoresSafeArea()

            VStack(spacing: 14) {
                header

                HStack(alignment: .top, spacing: 12) {
                    PhotoExampleCard(
                        imageName: "fotoValida",
                        title: "Foto válida",
                        text: "O círculo fica verde quando o animal está na mira.",
                        symbol: "checkmark.circle.fill",
                        tint: .green
                    )
                    PhotoExampleCard(
                        imageName: "fotoInvalida",
                        title: "Foto inválida",
                        text: "O círculo fica cinza quando não há um alvo válido.",
                        symbol: "xmark.circle.fill",
                        tint: .gray
                    )
                }
                .frame(maxHeight: .infinity)

                VStack(spacing: 10) {
                    TipRow(
                        symbol: "hand.draw.fill",
                        text: "Arraste o dedo pela tela para explorar o cenário."
                    )
                    TipRow(
                        symbol: "arrow.up.left.and.arrow.down.right",
                        text: "Abra os dedos (pinça) para dar zoom e chegar mais perto."
                    )
                    TipRow(
                        symbol: "timer",
                        text: "Você tem \(Int(ExpeditionConfig.gameDuration)) segundos e \(ExpeditionConfig.totalPhotos) fotos."
                    )
                    TipRow(
                        symbol: "pawprint.fill",
                        text: "Os animais se movem de forma imprevisível. Fique atento!"
                    )
                }
                .padding(14)
                .background(.white, in: RoundedRectangle(cornerRadius: 20))

                Button {
                    vm.startGame()
                } label: {
                    Text("Começar Expedição")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(FaunaPalette.teal, in: Capsule())
                }
            }
            .foregroundStyle(.black)
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.bottom, 16)
        }
    }

    private var header: some View {
        VStack(spacing: 4) {
            Image(systemName: "binoculars.fill")
                .font(.system(size: 34))
                .foregroundStyle(FaunaPalette.teal)

            Text("Prepare-se!")
                .font(.title.bold())

            Text("A expedição vai começar. Veja algumas dicas:")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Cartão de exemplo (foto válida / inválida)
private struct PhotoExampleCard: View {
    let imageName: String
    let title: String
    let text: String
    let symbol: String
    let tint: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(tint, lineWidth: 3)
                )

            HStack(spacing: 4) {
                Image(systemName: symbol)
                    .foregroundStyle(tint)
                Text(title)
                    .font(.subheadline.bold())
            }

            Text(text)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.85)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(.white, in: RoundedRectangle(cornerRadius: 20))
    }
}

// MARK: - Linha de dica (SF Symbol + texto)
private struct TipRow: View {
    let symbol: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: symbol)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 34, height: 34)
                .background(FaunaPalette.teal, in: Circle())

            Text(text)
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 0)
        }
    }
}

#Preview {
    ExpeditionStartView(vm: ExpeditionViewState())
}
