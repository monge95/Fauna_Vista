//
//  ExpeditionSceneRepresentable.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine


// ============================================================
// MARK: - REALITYKIT + SWIFTUI
// ============================================================

struct ExpeditionSceneRepresentable: UIViewRepresentable {
    var vm: ExpeditionViewState

    func makeUIView(context: Context) -> ExpeditionSceneView {
        let view = ExpeditionSceneView(frame: .zero)
        view.vm = vm
        vm.connect(view)
        return view
    }

    func updateUIView(_ uiView: ExpeditionSceneView, context: Context) {
        vm.buildIfNeeded()
    }

    // O SwiftUI chama isto quando a view sai da tela (fim da partida, etc.).
    // Sem isto, a ExpeditionSceneView antiga ficava viva renderizando.
    static func dismantleUIView(_ uiView: ExpeditionSceneView, coordinator: ()) {
        uiView.teardown()
    }
}
