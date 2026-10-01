import SwiftUI
import SwiftData
@main struct MyApp: App {
    @State private var log = ExpeditionLog()
    
    var body: some Scene {
        WindowGroup {
            SwiftDataTestView()
        }
        .modelContainer(for: [
            Animal.self,
            Expedition.self,
            ExpeditionPhoto.self
        ])
    }
}
