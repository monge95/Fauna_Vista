//
//  OnboardingView.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 07/10/26.
//

import SwiftUI

struct OnboardingView: View {

    @Environment(AppCoordinator.self)
    private var coordinator

    var body: some View {

        @Bindable var coordinator = coordinator

        NavigationStack(path: $coordinator.pathOnboarding) {

            StartOnboarding()
                .navigationDestination(for: AppRoute.self) { route in
                    ViewFactory.viewBuilder(for: route)
                }
        }
        .onAppear {
            coordinator.isOnboarding = true
        }
    }
}
