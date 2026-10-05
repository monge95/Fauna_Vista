//
//  ExpeditionObjectCategory.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//

// MARK: - OBJETOS 3D DISPONÍVEIS
// Cada Empty no Blender deve ser nomeado, por exemplo:
// Posicao_Animal_1
// Posicao_Animal_2
// E cada posição aponta para um USDZ separado no projeto.
// Adicione logo antes do enum ExpeditionObjectType:
import SwiftUI
import UIKit
import RealityKit
import Combine



enum ExpeditionObjectCategory {
    case fauna
    case vegetation
}

 
