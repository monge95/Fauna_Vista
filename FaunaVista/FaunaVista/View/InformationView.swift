//
//  information.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 01/10/26.
//

import SwiftUI

struct InformationView: View {

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {

            header

            VStack(spacing: 24) {

                NavigationLink {
                    FrequentlyAskedQuestionsView()
                } label: {
                    InformationOptionCard(
                        icon: "questionmark.circle.fill",
                        title: "Dúvidas frequentes",
                        description: "Respostas para\nperguntas comuns"
                    )
                }
                .buttonStyle(.plain)


                NavigationLink {
                    ThirdPartyContentView()
                } label: {
                    InformationOptionCard(
                        icon: "link",
                        title: "Conteúdo de terceiros",
                        description: "Informações fornecidas\npor APIs externas"
                    )
                }
                .buttonStyle(.plain)


                NavigationLink {
                    PrivacyPolicyView()
                } label: {
                    InformationOptionCard(
                        icon: "lock.shield.fill",
                        title: "Política de privacidade",
                        description: "Seus dados e como\nos tratamos"
                    )
                }
                .buttonStyle(.plain)


                NavigationLink {
                    TermsOfUseView()
                } label: {
                    InformationOptionCard(
                        icon: "doc.fill",
                        title: "Termos de uso",
                        description: "Regras e diretrizes\ndo serviço"
                    )
                }
                .buttonStyle(.plain)
            
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)

            Spacer()
        }
        .background(
            Color("CardBackground")
                .ignoresSafeArea()
        )
        .navigationBarBackButtonHidden(true)
    }


    private var header: some View {
        ZStack {

            Text("Informações")
                .font(.custom("Belanosima-SemiBold", size: 28))
                .foregroundStyle(.black)

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
        InformationView()
    }
}


