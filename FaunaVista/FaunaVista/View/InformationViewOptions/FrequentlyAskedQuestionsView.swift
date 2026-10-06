//
//  FrequentlyAskedQuestionsView.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 05/10/26.
//

import SwiftUI

struct FrequentlyAskedQuestionsView: View {

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {

            header

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    Text("""
                    Nas expedições do FaunaVista, você explora virtualmente diferentes biomas brasileiros em busca de espécies da fauna.

                    Para observar o ambiente, arraste o dedo pela tela para olhar ao redor e procurar os animais. Quando encontrar uma espécie, tente posicioná-la dentro do enquadramento da câmera.
                    """)
                    .font(.system(size: 14))

                    Image("ExpeditionHelp")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 30)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("""
                        Ao encontrar o momento certo, toque no botão de fotografar para realizar o registro. A qualidade da foto será avaliada de acordo com alguns fatores, como:
                        """)
                        .font(.system(size: 14))

                        Text("""
                        • Enquadramento: quanto melhor o animal estiver posicionado e visível na tela, melhor será o registro.

                        • Distância: aproximar-se da espécie na medida certa ajuda a obter uma foto de maior qualidade.

                        • Visibilidade: obstáculos do ambiente, como vegetação e galhos, podem esconder parte do animal e influenciar a avaliação.
                        """)
                        .font(.system(size: 14))

                        Text("""
                        Depois de fotografar, o aplicativo avalia o registro e apresenta a pontuação obtida. O objetivo é encontrar os animais, observar o ambiente e conseguir os melhores registros possíveis durante a expedição virtual.
                        """)
                        .font(.system(size: 14))
                    }
                }
                .foregroundStyle(.black)
                .padding(32)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("InformationCardBackground"))
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 40)
            }
        }
        .background(
            Color("CardBackground")
                .ignoresSafeArea()
        )
        .navigationBarBackButtonHidden(true)
    }

    private var header: some View {
        ZStack {
            Text("Dúvidas\nfrequentes")
                .font(.custom("Belanosima-SemiBold", size: 28))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.green)
                        .frame(width: 44, height: 44)
                        .background {
                            Circle()
                                .fill(.ultraThinMaterial)
                        }
                }
                .buttonStyle(.plain)

                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

#Preview {
    NavigationStack {
        FrequentlyAskedQuestionsView()
    }
}
