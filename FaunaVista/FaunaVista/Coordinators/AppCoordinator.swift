//
//  AppCoordinator.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 28/09/26.
//

import SwiftUI
import Observation

@Observable
class AppCoordinator {

    var selectedView: AppTap = .Map

    var pathMapa = NavigationPath()
    var pathColecao = NavigationPath()
    var pathOnboarding = NavigationPath()

    var isOnboarding = false

    func push(_ route: AppRoute) {

        if isOnboarding {
            pathOnboarding.append(route)
        } else if selectedView == .Map {
            pathMapa.append(route)
        } else {
            pathColecao.append(route)
        }
    }

    func pop() {

        if isOnboarding && !pathOnboarding.isEmpty {
            pathOnboarding.removeLast()

        } else if selectedView == .Map && !pathMapa.isEmpty {
            pathMapa.removeLast()

        } else if selectedView == .Collection && !pathColecao.isEmpty {
            pathColecao.removeLast()
        }
    }

    func reset() {
        pathMapa = NavigationPath()
        pathColecao = NavigationPath()
        pathOnboarding = NavigationPath()

        selectedView = .Collection
        isOnboarding = false
    }
    func resetOnboarding() {
        pathMapa = NavigationPath()
        pathColecao = NavigationPath()
        pathOnboarding = NavigationPath()

        selectedView = .Map
        isOnboarding = false
    }
}
