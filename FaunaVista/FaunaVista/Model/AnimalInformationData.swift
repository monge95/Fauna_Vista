//
//  AnimalInformationData.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 02/10/26.
//

import Foundation

struct AnimalInformationData {

    static let information: [String: AnimalInformation] = [

        "Myrmecophaga tridactyla": AnimalInformation(
            characteristics: """
            O tamanduá-bandeira é um dos maiores tamanduás do mundo. Sua característica mais marcante é a enorme cauda, coberta por pelos longos.
            """,

            behavior: """
            É um animal geralmente solitário e pode ter hábitos diurnos ou noturnos, dependendo das condições do ambiente. Usa suas longas garras para abrir formigueiros e cupinzeiros e captura o alimento com uma língua comprida e pegajosa.
            """,

            curiosity: """
            O tamanduá-bandeira não possui dentes e utiliza sua língua comprida e pegajosa para se alimentar principalmente de formigas e cupins.
            """,

            threats: """
            Entre suas principais ameaças estão a perda e fragmentação do habitat, incêndios e atropelamentos.
            """
        ),
        
        "Inia geoffrensis": AnimalInformation(
            characteristics: """
            O boto-cor-de-rosa possui corpo robusto, focinho longo e nadadeiras largas. Sua coloração pode variar entre tons de cinza e rosa, sendo que alguns indivíduos adultos apresentam uma tonalidade rosada bastante marcante.
            """,

            behavior: """
            Pode ser ativo tanto durante o dia quanto à noite. É um nadador ágil em ambientes de rios e florestas alagadas e costuma explorar diferentes áreas em busca de peixes. Embora geralmente seja visto sozinho, também pode se reunir com outros botos durante a alimentação.
            """,

            curiosity: """
            Diferentemente dos golfinhos marinhos, as vértebras do pescoço do boto não são fundidas, permitindo que ele movimente a cabeça com maior liberdade para navegar entre árvores e obstáculos nas áreas alagadas.
            """,

            threats: """
            Entre suas principais ameaças estão a captura e morte associadas à pesca, a construção de barragens, a degradação dos rios e a contaminação do ambiente por substâncias como o mercúrio.
            """
        ),

        "Cacajao rubicundus": AnimalInformation(
            characteristics: """
            O uacari-vermelho é um primata amazônico que apresenta pelagem avermelhada e uma cauda relativamente curta quando comparada à de muitos outros macacos. Sua cabeça possui menos pelos e sua aparência é bastante característica.
            """,

            behavior: """
            Vive nas florestas amazônicas e pode formar grupos para se deslocar e procurar alimento. Sua alimentação inclui principalmente frutos e sementes, e suas mandíbulas fortes ajudam a abrir sementes de casca dura.
            """,

            curiosity: """
            Os uacaris possuem dentes e mandíbulas adaptados para quebrar sementes resistentes que muitos outros primatas teriam dificuldade para consumir.
            """,

            threats: """
            Ainda existem lacunas no conhecimento sobre essa espécie. A caça é uma ameaça registrada, enquanto alterações climáticas e mudanças no ambiente florestal também podem afetar suas populações.
            """
        ),

        "Chrysocyon brachyurus": AnimalInformation(
            characteristics: """
            O lobo-guará é o maior canídeo da América do Sul. Possui pernas muito longas, grandes orelhas e pelagem predominantemente avermelhada, com regiões escuras nas patas e na crina.
            """,

            behavior: """
            É geralmente solitário e apresenta maior atividade ao entardecer e durante a noite. Percorre grandes áreas em busca de alimento e utiliza urina e fezes para marcar seu território.
            """,

            curiosity: """
            Apesar do nome, o lobo-guará não se comporta como os lobos que vivem em grandes alcateias. Ele costuma caçar e se deslocar sozinho e possui uma dieta variada, que inclui tanto animais quanto frutos.
            """,

            threats: """
            Suas principais ameaças incluem a perda e alteração do habitat, atropelamentos em rodovias, perseguição por seres humanos e doenças transmitidas por animais domésticos.
            """
        ),

        "Anodorhynchus leari": AnimalInformation(
            characteristics: """
            A arara-azul-de-lear possui plumagem predominantemente azul, com tonalidades esverdeadas, além de uma região amarela próxima ao bico. É uma grande ave da família dos psitacídeos e ocorre naturalmente na Caatinga baiana.
            """,

            behavior: """
            É uma ave social que costuma formar grupos. Ao amanhecer, deixa os locais onde passa a noite para procurar alimento e retorna no final da tarde. Utiliza paredões e cavidades rochosas para descanso e reprodução.
            """,

            curiosity: """
            O licuri é um alimento muito importante para a arara-azul-de-lear. Seu bico forte permite quebrar os frutos dessa palmeira para alcançar as sementes.
            """,

            threats: """
            A espécie é ameaçada principalmente pela perda e degradação do habitat, redução de recursos alimentares, captura ilegal para o tráfico de animais silvestres e conflitos em áreas agrícolas.
            """
        ),

        "Tolypeutes tricinctus": AnimalInformation(
            characteristics: """
            O tatu-bola possui uma carapaça rígida e arredondada formada por placas, com três faixas móveis na região central. Também apresenta cabeça pequena, focinho pontudo e fortes garras nas patas dianteiras.
            """,

            behavior: """
            É um animal geralmente solitário, com maior atividade no período noturno e ao entardecer. Alimenta-se principalmente de insetos, como formigas e cupins, e utiliza áreas protegidas para descansar.
            """,

            curiosity: """
            Quando se sente ameaçado, o tatu-bola consegue enrolar completamente o corpo, formando uma bola protegida pela carapaça. Poucas espécies de tatu possuem essa capacidade.
            """,

            threats: """
            A perda e transformação de seus ambientes naturais estão entre as principais ameaças à espécie. A caça e outras alterações humanas na Caatinga e no Cerrado também contribuem para a redução de suas populações.
            """
        ),

        "Leontopithecus rosalia": AnimalInformation(
            characteristics: """
            O mico-leão-dourado é um pequeno primata reconhecido pela pelagem de coloração dourada a alaranjada e pelos longos ao redor da cabeça, que lembram a juba de um leão.
            """,

            behavior: """
            É uma espécie social que vive em pequenos grupos familiares. Os integrantes do grupo procuram alimento, descansam e cuidam dos filhotes em conjunto, além de utilizarem vocalizações para se comunicar.
            """,

            curiosity: """
            O cuidado dos filhotes é compartilhado pelo grupo. O pai e outros integrantes podem ajudar a carregar e proteger os jovens, enquanto a mãe é responsável pela amamentação.
            """,

            threats: """
            A perda e fragmentação da Mata Atlântica reduziram e separaram grande parte de seu habitat. Populações pequenas e isoladas ficam mais vulneráveis, tornando a conservação e conexão das áreas florestais especialmente importantes.
            """
        ),

        "Bradypus torquatus": AnimalInformation(
            characteristics: """
            A preguiça-de-coleira possui pelagem espessa e uma região de pelos mais longos e escuros ao redor do pescoço, semelhante a uma juba. Suas longas garras curvas são adaptadas para se prender aos galhos.
            """,

            behavior: """
            Passa a maior parte da vida nas árvores, onde se alimenta principalmente de folhas e descansa. Seus movimentos são lentos e ela pode apresentar atividade tanto durante o dia quanto à noite.
            """,

            curiosity: """
            Algas podem crescer sobre os pelos das preguiças, dando à pelagem uma tonalidade esverdeada. Essa característica pode ajudar o animal a se camuflar entre a vegetação.
            """,

            threats: """
            A perda, degradação e fragmentação da Mata Atlântica estão entre suas principais ameaças. A expansão de áreas agrícolas, pastagens, cidades e estradas reduz e separa o habitat disponível para a espécie.
            """
        ),

        "Pteronura brasiliensis": AnimalInformation(
            characteristics: """
            A ariranha é a maior espécie de lontra existente. Possui corpo alongado, patas adaptadas à natação e uma cauda larga e achatada. As manchas claras presentes na região da garganta variam entre os indivíduos.
            """,

            behavior: """
            É uma espécie bastante social e vive em grupos familiares. Os integrantes do grupo nadam, descansam, defendem território e podem caçar juntos. Também utilizam diferentes vocalizações para se comunicar.
            """,

            curiosity: """
            As manchas claras presentes na garganta da ariranha funcionam quase como uma identificação individual, pois apresentam padrões diferentes em cada animal.
            """,

            threats: """
            Entre suas principais ameaças estão a destruição do habitat, poluição dos rios, contaminação por metais pesados, conflitos com seres humanos e redução da disponibilidade de peixes.
            """
        ),

        "Panthera onca": AnimalInformation(
            characteristics: """
            A onça-pintada é o maior felino das Américas. Possui corpo forte e musculoso, cabeça robusta e pelagem amarelada coberta por manchas negras em formato de rosetas.
            """,

            behavior: """
            É predominantemente solitária e territorial. Pode ser ativa em diferentes horários, com maior atividade próxima ao amanhecer e ao entardecer. É uma excelente nadadora e costuma ocupar ambientes próximos à água.
            """,

            curiosity: """
            A onça-pintada possui uma mordida extremamente poderosa e consegue perfurar estruturas resistentes, como cascos de tartarugas. Também é capaz de caçar presas tanto em terra quanto na água.
            """,

            threats: """
            A perda e fragmentação do habitat, a redução de presas e a perseguição humana estão entre suas principais ameaças. Conflitos podem ocorrer especialmente em regiões onde onças atacam animais de criação.
            """
        ),

        "Xanthopsar flavus": AnimalInformation(
            characteristics: """
            O veste-amarela é uma ave de pequeno porte e coloração bastante marcante. Os machos apresentam regiões amarelas intensas contrastando com partes escuras do corpo, enquanto as fêmeas possuem coloração mais discreta.
            """,

            behavior: """
            Vive principalmente em campos naturais, áreas úmidas e ambientes abertos. Pode formar grupos e utiliza a vegetação dos campos e banhados para alimentação, abrigo e construção de seus ninhos.
            """,

            curiosity: """
            Durante a reprodução, a vegetação do campo tem papel fundamental: determinadas plantas e arbustos servem de suporte para os ninhos, tornando a preservação desses ambientes essencial para a espécie.
            """,

            threats: """
            A transformação dos campos naturais em áreas agrícolas, pastagens e plantações florestais está entre suas principais ameaças. Drenagem de áreas úmidas, queimadas e uso de pesticidas também degradam seu habitat.
            """
        ),

        "Ceratophrys ornata": AnimalInformation(
            characteristics: """
            O sapo-de-chifres possui corpo arredondado, cabeça muito larga e uma boca proporcionalmente grande. Apresenta coloração e manchas que ajudam na camuflagem entre a vegetação e o solo.
            """,

            behavior: """
            É um predador de emboscada. Costuma permanecer parado e parcialmente escondido, esperando que uma presa se aproxime para realizar um ataque rápido com sua grande boca.
            """,

            curiosity: """
            Por causa do corpo arredondado e da boca enorme, espécies do gênero Ceratophrys ficaram conhecidas popularmente como “sapos-pacman”, em referência ao personagem dos videogames.
            """,

            threats: """
            A perda e alteração de seu habitat estão entre as ameaças à espécie. A captura para o comércio de animais e a morte intencional causada pela aversão de algumas pessoas a esses anfíbios também podem afetar suas populações.
            """
        )
    ]
}
