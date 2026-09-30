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
            
        case .ExpeditionSelector:
            ExpressionSelector()
            
        case .Expedition:
            ExpeditionView()
                    
        case .Analyze:
            AnalyzeView()
                    
        case .CheckExpedition:
            CheckExpeditionView()
                    
        case .registro:
            RegistroView()
        }
    }
}
