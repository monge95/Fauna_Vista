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
        )
    ]
}
