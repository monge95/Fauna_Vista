//
//  ExpeditionDebugAxis.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine



enum ExpeditionDebugAxis: String, CaseIterable, Identifiable { // Eixo escolhido nos controles de debug para mover o objeto em foco.
    case x = "X"
    case y = "Y"
    case z = "Z"

    var id: String { rawValue }

    var vector: SIMD3<Float> {
        switch self {
        case .x: return SIMD3<Float>(1, 0, 0)
        case .y: return SIMD3<Float>(0, 1, 0)
        case .z: return SIMD3<Float>(0, 0, 1)
        }
    }
}
