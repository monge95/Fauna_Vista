import SwiftUI
import SwiftData
@main struct MyApp: App {
    @State private var log = ExpeditionLog()
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
            .environment(log)            }
        .modelContainer(for: Animal.self)
    }
}
