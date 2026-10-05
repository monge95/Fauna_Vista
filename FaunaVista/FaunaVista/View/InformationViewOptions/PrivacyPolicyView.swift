//
//  PrivacyPolicyView.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 05/10/26.
//

import SwiftUI

struct PrivacyPolicyView: View {

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {

            header

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    Text("Última atualização: 25/09/2026")
                        .font(.system(size: 14, weight: .bold))

                    Text("""
                    A presente Política de Privacidade explica como o aplicativo FaunaVista trata as informações relacionadas aos seus usuários.

                    O FaunaVista é um aplicativo educacional e interativo voltado à exploração da fauna brasileira, permitindo que os usuários conheçam espécies ameaçadas de extinção, explorem os biomas brasileiros e participem de expedições virtuais e atividades de descoberta dentro do aplicativo.
                    """)
                    .font(.system(size: 14))

                    informationSection(
                        title: "1. Coleta de dados pessoais",
                        text: """
                        O FaunaVista foi desenvolvido com o princípio de minimização de dados e, atualmente, não exige cadastro ou criação de conta para utilização do aplicativo.

                        O aplicativo não solicita diretamente informações pessoais como:
                        • nome;
                        • endereço;
                        • número de telefone;
                        • endereço de e-mail;
                        • CPF ou outros documentos;
                        • senha;
                        • informações de pagamento.

                        O FaunaVista também não possui, em sua versão atual, um sistema de perfil de usuário ou armazenamento de informações pessoais em servidores próprios.
                        """
                    )

                    informationSection(
                        title: "2. Dados armazenados no dispositivo",
                        text: """
                        Para permitir o funcionamento de suas funcionalidades, o FaunaVista poderá armazenar localmente no dispositivo informações relacionadas ao progresso do usuário, como:
                        • espécies descobertas;
                        • progresso de exploração dos biomas;
                        • expedições simuladas realizadas dentro do aplicativo;
                        • informações relacionadas à conclusão das expedições;
                        • registros simulados de fotografias realizados durante as expedições.

                        Essas informações são utilizadas exclusivamente para manter o funcionamento e o progresso do aplicativo.

                        Os dados relacionados ao progresso são armazenados localmente no dispositivo e, na versão atual, não são enviados para servidores próprios do FaunaVista.
                        """
                    )

                    informationSection(
                        title: "3. Registros fotográficos simulados",
                        text: """
                        O FaunaVista possui expedições virtuais interativas que simulam a fotografia de espécies da fauna brasileira em ambientes naturais.

                        Os registros fotográficos realizados durante essas expedições virtuais são simulações geradas pelo próprio aplicativo e não correspondem a fotografias capturadas pela câmera do dispositivo.

                        Dessa forma, o FaunaVista não solicita acesso à câmera do dispositivo e não coleta ou armazena fotografias pessoais do usuário.

                        Os registros simulados podem ser associados ao progresso das expedições e à coleção do usuário, permanecendo armazenados localmente quando necessário para o funcionamento do aplicativo.
                        """
                    )

                    informationSection(
                        title: "4. Dados e conteúdos provenientes de serviços externos",
                        text: """
                        O FaunaVista utiliza serviços externos para disponibilizar informações e conteúdos relacionados às espécies apresentadas no aplicativo.

                        iNaturalist: utilizado como fonte de informações relacionadas às espécies e observações da fauna, podendo fornecer dados como nome popular, nome científico, localização e outras informações disponibilizadas pela plataforma.

                        Wikimedia Commons: utilizado como fonte de imagens de espécies apresentadas no aplicativo. As imagens utilizadas são selecionadas de acordo com as licenças aplicáveis a cada arquivo, respeitando as condições de uso e atribuição estabelecidas pelos respectivos autores e licenciadores.

                        O FaunaVista não reivindica a propriedade dos conteúdos pertencentes a essas fontes. Informações sobre autoria, licença e origem dos conteúdos utilizados poderão ser consultadas na seção Fontes e Créditos do aplicativo.
                        """
                    )

                    informationSection(
                        title: "5. Compartilhamento de dados",
                        text: """
                        O FaunaVista não comercializa dados pessoais dos usuários.

                        Na versão atual, os dados relacionados ao progresso armazenados localmente não são compartilhados com terceiros pelo aplicativo.

                        Caso futuras versões passem a utilizar serviços que envolvam coleta, armazenamento ou compartilhamento de dados pessoais, esta Política de Privacidade será atualizada para informar quais dados serão tratados, para quais finalidades e com quais terceiros poderão ser compartilhados.
                        """
                    )

                    informationSection(
                        title: "6. Armazenamento e exclusão",
                        text: """
                        As informações relacionadas ao progresso do usuário são armazenadas localmente no dispositivo.

                        A exclusão do aplicativo poderá remover os dados locais associados ao seu funcionamento, conforme o comportamento do sistema operacional e das configurações de armazenamento do dispositivo.

                        Caso o FaunaVista passe a oferecer armazenamento de dados em servidores ou contas de usuário, serão disponibilizados mecanismos específicos para solicitação de acesso, correção ou exclusão desses dados.
                        """
                    )

                    informationSection(
                        title: "7. Privacidade de crianças e adolescentes",
                        text: """
                        O FaunaVista possui finalidade educacional e pode ser utilizado por estudantes.

                        O aplicativo não solicita diretamente informações pessoais para criação de contas ou identificação dos usuários.

                        Pais, responsáveis e instituições de ensino podem entrar em contato conosco caso tenham dúvidas relacionadas ao tratamento de dados no aplicativo.
                        """
                    )

                    informationSection(
                        title: "8. Segurança",
                        text: """
                        Adotamos medidas técnicas compatíveis com a estrutura do aplicativo para reduzir riscos relacionados ao acesso indevido às informações armazenadas.

                        Como o FaunaVista não mantém, em sua versão atual, uma conta de usuário ou banco de dados próprio contendo informações pessoais, grande parte das informações relacionadas ao progresso permanece no dispositivo utilizado pelo usuário.
                        """
                    )

                    informationSection(
                        title: "9. Direitos dos usuários",
                        text: """
                        Nos termos da legislação aplicável, incluindo a Lei Geral de Proteção de Dados Pessoais — LGPD, os usuários poderão exercer os direitos aplicáveis aos seus dados pessoais, incluindo aqueles relacionados à confirmação da existência de tratamento, acesso, correção e eliminação, quando cabíveis.

                        Para solicitações ou dúvidas relacionadas à privacidade, entre em contato pelo e-mail:
                        joicenunes.ca@gmail.com
                        """
                    )

                    informationSection(
                        title: "10. Alterações nesta Política de Privacidade",
                        text: """
                        Esta Política de Privacidade poderá ser atualizada para refletir alterações nas funcionalidades do FaunaVista, nos serviços utilizados ou na legislação aplicável.

                        Quando houver alterações relevantes, a versão atualizada será disponibilizada no aplicativo e/ou nos canais oficiais relacionados ao FaunaVista.
                        """
                    )

                    informationSection(
                        title: "11. Contato",
                        text: """
                        Em caso de dúvidas, sugestões ou solicitações relacionadas à privacidade, entre em contato:

                        FaunaVista

                        Responsável: Felipe Colares, Gabriel Groppo, Joice Cardoso, Pedro Monge
                        E-mail: joicenunes.ca@gmail.com

                        Última atualização: 25/09/2026
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
            Text("Política de\nPrivacidade")
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
        PrivacyPolicyView()
    }
}
