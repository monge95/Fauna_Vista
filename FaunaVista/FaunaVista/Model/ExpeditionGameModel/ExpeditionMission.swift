//
//  ExpeditionMission.swift
//

import SwiftUI

// Estado de animação em que o animal estava no instante da foto.
enum ExpeditionAnimalPose: String {
    case idle, walking, action

    var displayName: String {
        switch self {
        case .idle:    return "Parado"
        case .walking: return "Andando"
        case .action:  return "Executando ação"
        }
    }
}

// As 3 missões. Para criar outra: adicione um case, o texto e a regra.
enum ExpeditionMission: Int, CaseIterable, Identifiable {
    case minimumStars
    case walking
    case action

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .minimumStars:
            return "Tire uma foto do animal, em qualquer estado, com avaliação de pelo menos \(ExpeditionConfig.missionMinimumStars) estrelas."
        case .walking:
            return "Tire uma foto do animal andando."
        case .action:
            return "Tire uma foto do animal executando a ação."
        }
    }

    // Só conta foto do animal da missão (animalID) que foi avaliável.
    func isCompleted(by photos: [ExpeditionPhoto], animalID: String) -> Bool {
        let valid = photos.filter { $0.animalID == animalID && $0.isScorable }

        switch self {
        case .minimumStars:
            return valid.contains { $0.stars >= ExpeditionConfig.missionMinimumStars }
        case .walking:
            return valid.contains { $0.pose == .walking }
        case .action:
            return valid.contains { $0.pose == .action }
        }
    }
}

enum FaunaPalette {
    static let teal = Color(red: 0.06, green: 0.43, blue: 0.43)
    static let tealLight = Color(red: 0.64, green: 0.83, blue: 0.82)
    static let beige = Color(red: 0.94, green: 0.92, blue: 0.88)
}
