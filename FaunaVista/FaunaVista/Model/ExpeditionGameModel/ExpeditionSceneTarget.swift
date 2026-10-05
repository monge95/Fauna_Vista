//
//  ExpeditionSceneTarget.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine


// ============================================================
// MARK: - CENA 3D
// ============================================================

enum ExpeditionSceneTarget {
   
    case object(ExpeditionObjectType)
    case animal(ExpeditionAnimalDefinition)

    var displayName: String {
        switch self {
        case .object(let type): return type.displayName
        case .animal(let animal): return animal.displayName
        }
    }
}

 
