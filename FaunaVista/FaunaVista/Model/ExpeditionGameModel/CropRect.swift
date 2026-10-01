//
//  CropRect.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

// ============================================================
// MARK: - MEDIÇÃO DA MOLDURA
// ============================================================

import SwiftUI
import UIKit
import RealityKit
import Combine

struct CropRectKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(
        value: inout CGRect,
        nextValue: () -> CGRect
    ) {
        value = nextValue()
    }
}
