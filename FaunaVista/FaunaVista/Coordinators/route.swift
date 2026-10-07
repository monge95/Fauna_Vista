//
//  Untitled.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 28/09/26.
//

import SwiftUI

enum AppTap: Hashable {
    case Map
    case Collection
}

enum AppRoute: Hashable{
    case Biome
    case Expedition
    case Analyze
    case CheckExpedition
    case registro
    
    case information
    
    case startOnboarding
    case exploreTerritories
    case findSpecies
    case observeImg
    case endOnboarding
}
