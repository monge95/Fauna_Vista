import SwiftUI
import SwiftData

@main
struct MyApp: App {
    
    @State var showSplash = true
    @State private var log = ExpeditionLog()
    @State private var coordinator = AppCoordinator()

    @AppStorage("hasCompletedOnboarding")
    
    private var hasCompletedOnboarding = false

    var body: some Scene {
        WindowGroup {
            ZStack {
                
                if showSplash {
                    SplashVideoView(
                        videoName: hasCompletedOnboarding ?  "FaunaVista_Mapa" : "splashAbertura"
                    ) {
                        withAnimation(.easeOut(duration: 0.4)) {
                            showSplash = false
                        }
                    }
                    .zIndex(1)
                }
                 
                            if hasCompletedOnboarding {
                                CoordinatorView()
                                    .environment(coordinator)
                                    .environment(log)

                            } else {
                             
                                OnboardingView()
                                    .environment(coordinator)
                                    .environment(log)
                            }

          
                        }
            .preferredColorScheme(.light)
        }
        .modelContainer(for: [
            Animal.self,
            Expedition.self,
            ExpeditionPhotoModel.self
        ])
    }
}
