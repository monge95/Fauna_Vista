import SwiftUI
import SwiftData
@main struct MyApp: App {
    @State private var log = ExpeditionLog()
    @State private var coordinator = AppCordinator()
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environment(coordinator)
                .environment(log)
        }
        .modelContainer(for: [
            Animal.self,
            Expedition.self,
            ExpeditionPhotoModel.self
        ])
    }
}

