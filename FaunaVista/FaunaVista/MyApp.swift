import SwiftUI
import SwiftData

@main
struct MyApp: App {

    @State private var log = ExpeditionLog()
    @State private var coordinator = AppCoordinator()

    @AppStorage("hasCompletedOnboarding")
    private var hasCompletedOnboarding = false

    var body: some Scene {
        WindowGroup {

            if hasCompletedOnboarding {
                CoordinatorView()
                    .environment(coordinator)
                    .environment(log)
                    .preferredColorScheme(.light)

            } else {
                OnboardingView()
                    .environment(coordinator)
                    .environment(log)
                    .preferredColorScheme(.light)
            }
        }
        .modelContainer(for: [
            Animal.self,
            Expedition.self,
            ExpeditionPhotoModel.self
        ])
    }
}
