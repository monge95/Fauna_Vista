//
//  ThirdPartyContentView.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 05/10/26.
//

import SwiftUI

struct ThirdPartyContentView: View {

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {

            header

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    informationSection(
                        title: "API iNaturalist",
                        text: """
                        O FaunaVista utiliza a API pública do iNaturalist para obter informações sobre espécies de animais observadas no Brasil. O iNaturalist é uma plataforma de biodiversidade mantida em conjunto pela California Academy of Sciences e pela National Geographic Society.

                        No aplicativo, essa integração é utilizada para buscar e fornecer informações sobre mamíferos registrados no Brasil, contribuindo para a composição da lista de espécies apresentada ao usuário.

                        A partir dos dados retornados pela API, o FaunaVista utiliza principalmente:

                        • Identificador (ID): código único utilizado para identificar a espécie na base de dados.
                        • Nome popular: nome comum da espécie, apresentado em português quando disponível.
                        • Nome científico: nome científico da espécie em latim.
                        • Localização: informação aproximada sobre o local onde a espécie foi registrada.
                        • Status de conservação: informação relacionada à situação de conservação da espécie, quando disponível.

                        Endpoint utilizado:
                        https://api.inaturalist.org/v1/observations

                        Parâmetros utilizados:
                        place_id=6878&iconic_taxa=Mammalia&locale=ptBR&preferred_place_id=6878&per_page=10

                        Esses dados são utilizados para complementar as informações sobre a fauna apresentada no aplicativo.
                        """
                    )

                    informationSection(
                        title: "API Wikimedia Commons",
                        text: """
                        O FaunaVista também utiliza a API da Wikimedia Commons para localizar imagens de animais que são exibidas no aplicativo. A Wikimedia Commons é um acervo público de arquivos multimídia mantido pela Wikimedia Foundation.

                        A integração permite que o aplicativo realize uma pesquisa automática pelo nome do animal e obtenha uma imagem correspondente para apresentar ao usuário.

                        Da resposta da API, o FaunaVista utiliza exclusivamente:

                        • Imagem (URL): endereço da imagem disponível na Wikimedia Commons. O aplicativo prioriza o endereço da miniatura (thumburl) e, quando necessário, utiliza o endereço original (url).

                        O endereço da imagem é utilizado pelo aplicativo para carregar e exibir a fotografia correspondente à espécie.

                        Não são armazenadas ou utilizadas pelo aplicativo outras informações retornadas nessa consulta, como título da página, autor ou dimensões da imagem.

                        Endpoint utilizado:
                        https://commons.wikimedia.org/w/api.php
                        """
                    )

                    informationSection(
                        title: "Como as duas APIs trabalham juntas",
                        text: """
                        De forma simplificada, as duas integrações possuem funções diferentes dentro do FaunaVista:

                        iNaturalist → informações sobre a espécie
                        Identifica e fornece dados sobre os animais e suas observações.

                        Wikimedia Commons → imagem da espécie
                        Localiza uma imagem correspondente ao animal para ser apresentada na interface do aplicativo.

                        Dessa forma, o FaunaVista combina dados de biodiversidade provenientes do iNaturalist com imagens disponíveis na Wikimedia Commons para enriquecer as informações apresentadas sobre as espécies.
                        """
                    )
                }
                .foregroundStyle(.black)
                .padding(20)
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
            Text("Conteúdo\nde terceiros (API)")
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

    private func informationSection(
        title: String,
        text: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 14, weight: .bold))

            Text(text)
                .font(.system(size: 14))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    NavigationStack {
        ThirdPartyContentView()
    }
}
