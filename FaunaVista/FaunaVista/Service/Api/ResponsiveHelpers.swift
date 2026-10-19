//
//  ResponsiveHelpers.swift
//  FaunaVista
//
//  Created by Felipe Colares Cardoso on 19/10/26. 
//
//

import SwiftUI

// MARK: - Fundo que nunca estoura a tela
/// Substitui `Image(...).resizable().scaledToFill().ignoresSafeArea()` dentro do ZStack.
/// A imagem com scaledToFill dentro do ZStack aumentava o tamanho do layout
/// no iPad e empurrava o conteúdo para fora da tela. Aqui ela fica presa ao tamanho real.
/// Uso: `.background { ScreenBackground(name: "BackGroundMap") }`
struct ScreenBackground: View {
    let name: String

    var body: some View {
        GeometryReader { geo in
            Image(name)
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
        }
        .ignoresSafeArea()
    }
}

// MARK: - Escala conteúdo de tamanho fixo para caber no espaço disponível
/// O mapa foi desenhado em 491.8 x 504.17 com posições absolutas dos biomas/pins.
/// Em vez de mexer em cada posição, o conjunto inteiro é escalado para caber
/// no espaço que sobrar (iPhone, iPad, janela redimensionada...).
struct FitToSpace<Content: View>: View {
    let designSize: CGSize
    var maxScale: CGFloat = 1.4
    let content: Content

    init(
        designSize: CGSize,
        maxScale: CGFloat = 1.4,
        @ViewBuilder content: () -> Content
    ) {
        self.designSize = designSize
        self.maxScale = maxScale
        self.content = content()
    }

    var body: some View {
        GeometryReader { geo in
            let scale = max(
                0.1,
                min(
                    geo.size.width / designSize.width,
                    geo.size.height / designSize.height,
                    maxScale
                )
            )

            content
                .frame(width: designSize.width, height: designSize.height)
                .scaleEffect(scale, anchor: .center)
                .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

// MARK: - Botões < > do onboarding
struct OnboardingNavButtons: View {
    let onBack: () -> Void
    let onNext: () -> Void

    var body: some View {
        HStack(spacing: 30) {
            circleButton("chevron.left", action: onBack)
            circleButton("chevron.right", action: onNext)
        }
    }

    private func circleButton(_ symbol: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.system(size: 25, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 50, height: 50)
        }
        .glassEffect(.regular, in: .circle)
    }
}
