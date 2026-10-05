//
//  ExpeditionObjectType.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine


enum ExpeditionObjectType: String, CaseIterable, Identifiable { // elementos em cena
    case objetoTeste1
    case vegetacao1
    case vegetacao2
    case vegetacao3
    case vegetacao4
    case vegetacao5
    case vegetacao6
    case vegetacao7
    case vegetacao8
    case vegetacao9
    case vegetacao10
    case vegetacao11
    case vegetacao12
    case vegetacao13
    case vegetacao14
    case vegetacao15
    case vegetacao16
    case vegetacao17
    case vegetacao18
    case vegetacao19
    case vegetacao20
    case vegetacao21
    case vegetacao22
    case vegetacao23
    case vegetacao24
    case vegetacao25
    case vegetacao26
    case vegetacao27
    case vegetacao28
    case vegetacao29
    case vegetacao30
 
    var id: String { rawValue }

    // vegetacao12 → 12. objetoTeste1 → nil.
    var slotNumber: Int? {
        guard rawValue.hasPrefix("vegetacao") else { return nil }
        return Int(rawValue.dropFirst("vegetacao".count))
    }

    var displayName: String { slotNumber == nil ? "Fauna" : "Vegetação" }

    var positionName: String {
        if let n = slotNumber { return "Vegetacao_\(n)" }
        return "Posicao_Animal_1"
    }

    var category: ExpeditionObjectCategory {
        slotNumber == nil ? .fauna : .vegetation
    }

    // Modelo 3D do slot, conforme a fase atual.
    func modelName(in level: ExpeditionLevel) -> String? {
        guard let n = slotNumber else { return nil }
        return level.treeSlots.contains(n) ? level.treeModel : level.grassModel
    }
   /* var displayName: String { // nome do objeto na View do APP
        switch self {
        case .objetoTeste1:
            return "Tamanduá Bandeira"
        case .vegetacao1:
            return "Vegetação"
        case .vegetacao2:
            return "Arvore"
        case .vegetacao3:
            return "Vegetação"
        case .vegetacao4:
            return "Vegetação"
        case .vegetacao5:
            return "Vegetação"
        case .vegetacao6:
            return "Arvore"
        case .vegetacao7:
            return "Vegetação"
        case .vegetacao8:
            return "Vegetação"
        case .vegetacao9:
            return "Vegetação"
        case .vegetacao10:
            return "Vegetação"
        case .vegetacao11:
            return "Arvore"
        case .vegetacao12:
            return "Vegetação"
        case .vegetacao13:
            return "Vegetação"
        case .vegetacao14:
            return "Vegetação"
        case .vegetacao15:
            return "Arvore"
        case .vegetacao16:
            return "Vegetação"
        case .vegetacao17:
            return "Vegetação"
        case .vegetacao18:
            return "Vegetação"
        case .vegetacao19:
            return "Vegetação"
        case .vegetacao20:
            return "Vegetação"
        case .vegetacao21:
            return "Vegetação"
        case .vegetacao22:
            return "Vegetação"
        case .vegetacao23:
            return "Vegetação"
        case .vegetacao24:
            return "Vegetação"
        case .vegetacao25:
            return "Vegetação"
        case .vegetacao26:
            return "Vegetação"
        case .vegetacao27:
            return "Vegetação"
        case .vegetacao28:
            return "Vegetação"
        case .vegetacao29:
            return "Vegetação"
        case .vegetacao30:
            return "Vegetação"
        }
    }

    var modelName: String { // nome do arquivo 3d no inspector
        switch self {
        case .objetoTeste1:
            return "tamandua_all" // animal
        case .vegetacao1:
            return "gramaCerrado"
        case .vegetacao2:
            return "arvorecerrado1"
        case .vegetacao3:
            return "gramaCerrado"
        case .vegetacao4:
            return "gramaCerrado"
        case .vegetacao5:
            return "gramaCerrado"
        case .vegetacao6:
            return "arvorecerrado1"
        case .vegetacao7:
            return "gramaCerrado"
        case .vegetacao8:
            return "gramaCerrado"
        case .vegetacao9:
            return "gramaCerrado"
        case .vegetacao10:
            return "gramaCerrado"
        case .vegetacao11:
            return "arvorecerrado1"
        case .vegetacao12:
            return "gramaCerrado"
        case .vegetacao13:
            return "gramaCerrado"
        case .vegetacao14:
            return "gramaCerrado"
        case .vegetacao15:
            return "arvorecerrado1"
        case .vegetacao16:
            return "gramaCerrado"
        case .vegetacao17:
            return "gramaCerrado"
        case .vegetacao18:
            return "gramaCerrado"
        case .vegetacao19:
            return "gramaCerrado"
        case .vegetacao20:
            return "gramaCerrado"
        case .vegetacao21:
            return "gramaCerrado"
        case .vegetacao22:
            return "gramaCerrado"
        case .vegetacao23:
            return "gramaCerrado"
        case .vegetacao24:
            return "gramaCerrado"
        case .vegetacao25:
            return "gramaCerrado"
        case .vegetacao26:
            return "gramaCerrado"
        case .vegetacao27:
            return "gramaCerrado"
        case .vegetacao28:
            return "gramaCerrado"
        case .vegetacao29:
            return "gramaCerrado"
        case .vegetacao30:
            return "gramaCerrado"
        }
    }

    var positionName: String {// objeto aempty posicionado e nomeado no blender
        switch self {
        case .objetoTeste1:
            return "Posicao_Animal_1"
        case .vegetacao1:
            return "Vegetacao_1"
        case .vegetacao2:
            return "Vegetacao_2"
        case .vegetacao3:
            return "Vegetacao_3"
        case .vegetacao4:
            return "Vegetacao_4"
        case .vegetacao5:
            return "Vegetacao_5"
        case .vegetacao6:
            return "Vegetacao_6"
        case .vegetacao7:
            return "Vegetacao_7"
        case .vegetacao8:
            return "Vegetacao_8"
        case .vegetacao9:
            return "Vegetacao_9"
        case .vegetacao10:
            return "Vegetacao_10"
        case .vegetacao11:
            return "Vegetacao_11"
        case .vegetacao12:
            return "Vegetacao_12"
        case .vegetacao13:
            return "Vegetacao_13"
        case .vegetacao14:
            return "Vegetacao_14"
        case .vegetacao15:
            return "Vegetacao_15"
        case .vegetacao16:
            return "Vegetacao_16"
        case .vegetacao17:
            return "Vegetacao_17"
        case .vegetacao18:
            return "Vegetacao_18"
        case .vegetacao19:
            return "Vegetacao_19"
        case .vegetacao20:
            return "Vegetacao_20"
        case .vegetacao21:
            return "Vegetacao_21"
        case .vegetacao22:
            return "Vegetacao_22"
        case .vegetacao23:
            return "Vegetacao_23"
        case .vegetacao24:
            return "Vegetacao_24"
        case .vegetacao25:
            return "Vegetacao_25"
        case .vegetacao26:
            return "Vegetacao_26"
        case .vegetacao27:
            return "Vegetacao_27"
        case .vegetacao28:
            return "Vegetacao_28"
        case .vegetacao29:
            return "Vegetacao_29"
        case .vegetacao30:
            return "Vegetacao_30"
            
        }
    }

    // Fauna é avaliada com estrelas. Vegetação só bloqueia a mira.
    var category: ExpeditionObjectCategory {
        switch self {
        case .objetoTeste1:
            return .fauna
        case .vegetacao1:
            return .vegetation
        case .vegetacao2:
            return .vegetation
        case .vegetacao3:
            return .vegetation
        case .vegetacao4:
            return .vegetation
        case .vegetacao5:
            return .vegetation
        case .vegetacao6:
            return .vegetation
        case .vegetacao7:
            return .vegetation
        case .vegetacao8:
            return .vegetation
        case .vegetacao9:
            return .vegetation
        case .vegetacao10:
            return .vegetation
        case .vegetacao11:
            return .vegetation
        case .vegetacao12:
            return .vegetation
        case .vegetacao13:
            return .vegetation
        case .vegetacao14:
            return .vegetation
        case .vegetacao15:
            return .vegetation
        case .vegetacao16:
            return .vegetation
        case .vegetacao17:
            return .vegetation
        case .vegetacao18:
            return .vegetation
        case .vegetacao19:
            return .vegetation
        case .vegetacao20:
            return .vegetation
        case .vegetacao21:
            return .vegetation
        case .vegetacao22:
            return .vegetation
        case .vegetacao23:
            return .vegetation
        case .vegetacao24:
            return .vegetation
        case .vegetacao25:
            return .vegetation
        case .vegetacao26:
            return .vegetation
        case .vegetacao27:
            return .vegetation
        case .vegetacao28:
            return .vegetation
        case .vegetacao29:
            return .vegetation
        case .vegetacao30:
            return .vegetation
        }
    }
*/
    
    
    static func fromPositionName(_ name: String) -> ExpeditionObjectType? {
        let normalized = name
            .folding(options: .diacriticInsensitive, locale: .current)
            .lowercased()
            .replacingOccurrences(of: " ", with: "_")

        for object in allCases {
            let expected = object.positionName.lowercased()
            if normalized == expected {
                return object
            }
        }
        return nil
    }
}
