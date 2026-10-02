import SwiftUI
import SwiftData
@main struct MyApp: App {
    @State private var log = ExpeditionLog()
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
            //SwiftDataTestView()
            .environment(log)
        }
        .modelContainer(for: [
            Animal.self,
            Expedition.self,
            ExpeditionPhotoModel.self
        ])
    }
}

