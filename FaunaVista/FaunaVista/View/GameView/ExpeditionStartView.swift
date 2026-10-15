//
//  ExpeditionStartView.swift
//

import SwiftUI

struct ExpeditionStartView: View {
    var vm: ExpeditionViewState

    var body: some View {
        ZStack {
            FaunaPalette.beige.ignoresSafeArea()
            
            VStack(spacing: 14) {
                Spacer()
                header
                //Spacer()
                HStack(alignment: .top, spacing: 20) {
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
                //Spacer()
                
                Text("Instruções")
                    .padding(.trailing, 260)
                    .fontWeight(.semibold)
                    
                VStack(spacing: 10) {
                    TipRow(
                        symbol: "hand.draw.fill",
                        text: "Arraste o dedo pela tela para explorar o cenário."
                    )
                    Divider()
                    TipRow(
                        symbol: "arrow.up.left.and.arrow.down.right",
                        text: "Abra os dedos (pinça) para dar zoom e chegar mais perto."
                    )
                    Divider()
                    TipRow(
                        symbol: "timer",
                        text: "Você tem \(Int(ExpeditionConfig.gameDuration)) segundos e \(ExpeditionConfig.totalPhotos) fotos."
                    )
                    Divider()
                    TipRow(
                        symbol: "pawprint.fill",
                        text: "Os animais se movem de forma imprevisível. Fique atento!"
                    )
                }
                .padding(14)
                .background(.white, in: RoundedRectangle(cornerRadius: 20))
                .padding(.bottom, 15)

                Button {
                    vm.startExpeditionWithCountdown()
                } label: {
                    Text(
                        vm.isStartingExpedition
                            ? (vm.countdownNumber > 0
                                ? "Começando em \(vm.countdownNumber)"
                                : "Começando…")
                            : "Começar Expedição"
                    )
                        .font(.headline)
                        .foregroundStyle(vm.isStartingExpedition ? Color.black : Color.white)
                        .frame(maxWidth: 350)
                        .padding(.vertical, 16)
                        .background(
                            vm.isStartingExpedition ? Color.yellow : FaunaPalette.teal,
                            in: Capsule()
                        )
                }
                .disabled(vm.isStartingExpedition)
                Spacer()
            }
            .foregroundStyle(.black)
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.bottom, 28)
        }
    }

    private var header: some View {
        VStack(spacing: 4) {
            
            Text("Prepare-se")
                .font(.custom("Belanosima-SemiBold", size: 32))

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
        VStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 170, height: 157)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            HStack(spacing: 4) {
                Image(systemName: symbol)
                    .foregroundStyle(tint)
                Text(title)
                    .font(.subheadline.bold())
            }

            Text(text)
                .font(.system(size: 15))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.85)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 10)
                .padding(.horizontal, 12)
        }
        .frame(width: 170)
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
                .frame(width: 34, height: 44)
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
