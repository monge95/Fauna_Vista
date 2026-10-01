//
//  ExpeditionWorld.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine


// MARK: - BASE DO MUNDO 3D DO FAUNA VISTA

// O ambiente deste projeto NÃO usa os eixos tradicionais do RealityKit
// (Y para cima). Medido pelos controles de debug, com a câmera padrão:
//
//   X+  → vai para a DIREITA da tela      X-  → vai para a ESQUERDA
//   Y+  → VEM para a tela (perto)         Y-  → se AFASTA da tela (longe)
//   Z-  → SOBE                            Z+  → DESCE
//
// Ou seja: o "chão" é o plano X/Y e a vertical é o eixo Z (com Z- para cima).
// TODO cálculo de esquerda/direita, espelhamento e futuro billboard deve
// usar ExpeditionWorld, nunca assumir (0, 1, 0) como "para cima".
enum ExpeditionWorld {
    static let right = SIMD3<Float>(1, 0, 0)
    static let up = SIMD3<Float>(0, 0, -1)
    static let towardViewer = SIMD3<Float>(0, 1, 0)
    static let awayFromViewer = SIMD3<Float>(0, -1, 0)

    // Remove a componente vertical, deixando só o que acontece no chão (X/Y).
    static func flattened(_ vector: SIMD3<Float>) -> SIMD3<Float> {
        vector - simd_dot(vector, up) * up
    }
    // Quanto um vetor aponta para a direita da TELA, de -1 a +1.
    //  +1 = direita pura, -1 = esquerda pura,
    //   0 = indo/vindo na direção da câmera (sem lado definido).
    // `cameraRight` é o eixo X local da câmera já em coordenadas do mundo.
    static func screenHorizontal(
        of vector: SIMD3<Float>,
        cameraRight: SIMD3<Float>
    ) -> Float {
        let v = flattened(vector)
        let r = flattened(cameraRight)
        let vectorLength = simd_length(v)
        let rightLength = simd_length(r)

        guard vectorLength > 1e-5, rightLength > 1e-5 else { return 0 }

        return simd_dot(v / vectorLength, r / rightLength)
    }

    // Abaixo deste valor o movimento é considerado "de frente/de costas"
    // para a câmera e o sprite mantém o lado atual (evita ficar piscando).
    static let horizontalDeadZone: Float = 0.2
}
