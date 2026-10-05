//
//  ExpeditionPhoto.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine



// MARK: - RESULTADO DA FOTO
struct ExpeditionPhoto: Identifiable {
    let id = UUID()
    let image: UIImage
    let stars: Int
    let objectName: String
    let distance: Float?
    let isScorable: Bool
    let animalID: String?
    let pose: ExpeditionAnimalPose?
    let date = Date()
}
