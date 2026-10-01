//
//  ExpeditionMovementAxis.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

import SwiftUI
import UIKit
import RealityKit
import Combine



// Referência usada para decidir se o animal está indo para
enum ExpeditionMovementAxis { // a esquerda ou para a direita.
    case x       // usa -X / +X do mundo, ignorando a câmera
    case screen  // usa a horizontal REAL da câmera (recomendado)
}
