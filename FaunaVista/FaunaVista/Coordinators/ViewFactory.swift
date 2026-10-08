//
//  ViewFactory.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 28/09/26.
//

import SwiftUI

struct ViewFactory{

    @ViewBuilder
    static func viewBuilder(for route: AppRoute) -> some View{
        switch route {
        case .Biome:
            BiomeView()
            
        // fluxo principal
        case .Expedition:
            ExpeditionView()
                    
        case .CheckExpedition:
            CheckExpeditionView()
                    
        case .registro(let animal):
            AnimalDetailView(animal: animal)
            
            
        // fluuxo secundario 
        case .information:
            InformationView()
        
        // fluxo Onearding
        case .startOnboarding:
            StartOnboarding()
            
        case .exploreTerritories:
            ExploreTerritories()
            
        case .findSpecies:
            FindSpecies()
            
        case .observeImg:
            ObserveImg()
        
        case .endOnboarding:
            EndOnboarding()
        }
    
    }
}
