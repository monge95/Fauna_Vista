// xcode: set sdk=iOS

import SwiftUI
import Playgrounds

struct ContentView: View {
    @AppStorage("onboardingConcluido") var onboardingConcluido: Bool = false
   
    var body: some View {
            Group {
                if onboardingConcluido {
                    CoordinatorView()
                } else {
//                  OnboardingView()
                }
            }
            .animation(.easeInOut, value: onboardingConcluido)
        }
}

#Preview {
    ContentView()
}
