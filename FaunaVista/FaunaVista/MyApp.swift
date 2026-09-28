import SwiftUI
import SwiftData
@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            SwiftDataTestView()
        }
        .modelContainer(for: Animal.self)
    }
}
