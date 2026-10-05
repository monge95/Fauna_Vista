//
//  AppCordinator.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 28/09/26.
//

import SwiftUI
import Observation

@Observable
class AppCordinator{
    
    var selectedView: AppTap = .Map
    
    var pathMapa = NavigationPath()
    var pathColecao = NavigationPath()
    
    func push(_ route: AppRoute) {
            if selectedView == .Map {
                pathMapa.append(route)
            } else {
                pathColecao.append(route)
            }
        }
    
    func pop() {
            if selectedView == .Map && !pathMapa.isEmpty {
                pathMapa.removeLast()
            } else if selectedView == .Collection && !pathColecao.isEmpty {
                pathColecao.removeLast()
            }
        }
    
    func rezet() {
            pathMapa = NavigationPath()
            selectedView = .Collection
        }
    
    func retunStart(){
        
    }
}
