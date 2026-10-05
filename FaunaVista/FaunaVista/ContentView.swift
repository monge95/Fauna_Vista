// xcode: set sdk=iOS

import SwiftUI
import Playgrounds
import Combine



struct ContentView: View {
    @AppStorage("onboardingConcluido") var onboardingConcluido: Bool = false
    @StateObject private var vm = ExpeditionViewModel()
    var body: some View {
        Group {
            if onboardingConcluido {
                CoordinatorView()
            } else {
                //                  OnboardingView()
            }
        }
        .animation(.easeInOut, value: onboardingConcluido)
        
        
        /* var body: some View {
         switch vm.gameState {
         case .start:
         ExpeditionStartView(vm: vm)
         case .playing:
         ExpeditionGameView(vm: vm)
         case .finished:
         ExpeditionFinishedView(vm: vm)
         }
         }
        */
        /*
         // MARK: - APP
         @main
         struct PhotoExpeditionApp: SwiftUI.App {
         var body: some SwiftUI.Scene {
         WindowGroup {
         ContentView()
         }
         }
         }*/
    }
    
}

#Preview {
    ContentView()
}
