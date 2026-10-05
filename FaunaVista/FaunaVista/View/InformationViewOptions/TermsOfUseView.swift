//
//  TermsOfUseView.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 05/10/26.
//

import SwiftUI

struct TermsOfUseView: View {

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {

            header

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    Text("Última atualização: 25/09/2026")
                        .font(.system(size: 14, weight: .bold))

                    Text("""
                    Bem-vindo ao FaunaVista.

                    Estes Termos de Uso estabelecem as condições para utilização do aplicativo FaunaVista, desenvolvido com finalidade educacional e interativa para proporcionar a exploração da fauna brasileira e de seus biomas.

                    Ao utilizar o aplicativo, o usuário declara estar ciente destes Termos de Uso.
                    """)
                    .font(.system(size: 14))

                    informationSection(
                        title: "1. Sobre o FaunaVista",
                        text: """
                        O FaunaVista é um aplicativo educacional que apresenta informações sobre a fauna brasileira, seus biomas e espécies ameaçadas de extinção.

                        O aplicativo permite que o usuário:
                        • explore os biomas brasileiros;
                        • conheça diferentes espécies;
                        • consulte informações sobre animais e seus ambientes;
                        • participe de expedições virtuais interativas;
                        • realize registros fotográficos simulados durante as expedições virtuais;
                        • acompanhe seu progresso de exploração;
                        • construa sua coleção de espécies descobertas.
                        """
                    )

                    informationSection(
                        title: "2. Finalidade educacional",
                        text: """
                        O conteúdo apresentado pelo FaunaVista possui finalidade educacional e informativa.
                        As informações disponibilizadas no aplicativo não devem ser consideradas como substitutas de fontes oficiais, publicações científicas ou orientações de profissionais especializados.
                        Informações sobre classificação, distribuição, características e estado de conservação das espécies podem ser atualizadas ao longo do tempo. Sempre que aplicável, o aplicativo indicará as fontes utilizadas para disponibilização dessas informações.
                        """
                    )

                    informationSection(
                        title: "3. Uso adequado do aplicativo",
                        text: """
                        O usuário concorda em utilizar o FaunaVista de maneira adequada e compatível com sua finalidade.
                        Não é permitido utilizar o aplicativo para:
                        tentar acessar ou modificar seu funcionamento de forma não autorizada;
                        realizar engenharia reversa ou interferir indevidamente em seus sistemas;
                        utilizar o aplicativo para atividades ilegais;
                        utilizar conteúdos disponibilizados pelo aplicativo de maneira que viole direitos de terceiros;
                        explorar falhas ou vulnerabilidades do aplicativo com a intenção de causar danos.
                        """
                    )

                    informationSection(
                        title: "4. Expedições e registros simulados",
                        text: """
                        O FaunaVista possui expedições interativas que simulam a observação e o registro fotográfico de espécies da fauna brasileira dentro do aplicativo.
                        Durante essas expedições, o usuário pode realizar registros fotográficos simulados de acordo com os objetivos e desafios apresentados pelo aplicativo.
                        Esses registros fazem parte da experiência de exploração e não representam fotografias capturadas pela câmera do dispositivo.
                        O FaunaVista não utiliza a câmera do dispositivo para realizar essas simulações.
                        Os registros simulados podem ser utilizados para acompanhar o progresso do usuário nas expedições, na coleção de espécies e na exploração dos biomas.

                        """
                    )

                    informationSection(
                        title: "5. Conteúdo e fontes de terceiros",
                        text: """
                        O FaunaVista utiliza conteúdos e informações provenientes de serviços externos para complementar a experiência de exploração das espécies.
                        As informações relacionadas às espécies e observações podem ser obtidas por meio da iNaturalist, enquanto as imagens utilizadas para representar as espécies podem ser obtidas por meio do Wikimedia Commons.
                        Os conteúdos de terceiros permanecem sujeitos aos direitos autorais, licenças e demais condições estabelecidas por seus respectivos autores e responsáveis.
                        O FaunaVista não reivindica propriedade sobre esses conteúdos e, quando aplicável, disponibilizará as respectivas informações de autoria, fonte e licença na seção Fontes e Créditos do aplicativo.
                        """
                    )

                    informationSection(
                        title: "6. Propriedade intelectual",
                        text: """
                        Os elementos desenvolvidos especificamente para o FaunaVista, incluindo sua identidade visual, nome, logotipo, interface, textos originais, ilustrações e demais materiais próprios, são protegidos pela legislação aplicável de propriedade intelectual.
                        A utilização do aplicativo não concede ao usuário qualquer direito de propriedade sobre esses elementos.
                        Conteúdos pertencentes a terceiros permanecem sujeitos aos direitos e licenças de seus respectivos titulares.
                        """
                        
                    )
                    
                    informationSection(
                        title: "7. Disponibilidade do aplicativo",
                        text: """
                        Buscamos manter o FaunaVista disponível e funcionando adequadamente, mas não garantimos que o aplicativo estará livre de interrupções, erros ou indisponibilidades.
                        O funcionamento de determinadas funcionalidades pode depender de conexão com a internet, serviços externos ou disponibilidade das APIs utilizadas pelo aplicativo.
                        Serviços de terceiros podem sofrer alterações, interrupções ou indisponibilidades independentemente do controle da equipe responsável pelo FaunaVista.

                        """
                        
                    )
                    
                    informationSection(
                        title: "8.  Atualizações",
                        text: """
                        O FaunaVista poderá receber atualizações para corrigir erros, melhorar funcionalidades, atualizar conteúdos ou adicionar novos recursos.
                        Algumas funcionalidades poderão ser modificadas, substituídas ou removidas ao longo do desenvolvimento do aplicativo.
                        """
                        
                    )
                    
                    informationSection(
                        title: "9. Limitação de responsabilidade",
                        text: """
                        O FaunaVista é disponibilizado com finalidade educacional e informativa.
                        Não garantimos que todas as informações apresentadas estarão permanentemente atualizadas ou completas.
                        A equipe responsável pelo aplicativo não se responsabiliza por decisões tomadas exclusivamente com base nas informações apresentadas no aplicativo.
                        """
                        
                    )
                    
                    informationSection(
                        title: "10. Privacidade",
                        text: """
                        O tratamento de informações relacionadas aos usuários é descrito em nossa Política de Privacidade.
                        A Política de Privacidade integra estes Termos de Uso e deve ser consultada para compreender como as informações são tratadas pelo aplicativo.
                        """
                        
                    )
                    
                    informationSection(
                        title: "11. Alterações dos Termos",
                        text: """
                        Estes Termos de Uso poderão ser atualizados quando houver mudanças relevantes no aplicativo, em seus serviços ou na legislação aplicável.
                        A versão mais recente estará disponível dentro do aplicativo e/ou nos canais oficiais do FaunaVista.
                        """
                        
                    )
                    
                    informationSection(
                        title: "12. Contato",
                        text: """
                        Para dúvidas, sugestões ou solicitações relacionadas ao FaunaVista, entre em contato:
                        FaunaVista
                         Responsável: [Felipe Colares, Gabriel Groppo Joice Cardoso, Pedro Monge] E-mail: [joicenunes.ca@gmail.com]
                        Última atualização: [25/09/2026]
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

            Text("Termos de uso")
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


    private func informationSection(
        title: String,
        text: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {

            Text(title)
                .font(.system(size: 14, weight: .bold))

            Text(text)
                .font(.system(size: 14))
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
        }
    }
}


#Preview {
    NavigationStack {
        TermsOfUseView()
    }
}
