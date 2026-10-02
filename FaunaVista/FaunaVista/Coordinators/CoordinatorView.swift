//
//  CoordinatorView.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 28/09/26.
//
import SwiftUI
import SwiftData

struct CoordinatorView: View{
    @State private var coordinator = AppCordinator()
   
    var body: some View{
        TabView(selection: $coordinator.selectedView) {
            NavigationStack(path: $coordinator.pathMapa) {
                MapView()
                    .navigationDestination(for: AppRoute.self) { rota in
                        ViewFactory.viewBuilder(for: rota)
                            .toolbar(.hidden, for: .tabBar)

                    }
            }
            .tabItem {Label(
                "Mapa",
                image: coordinator.selectedView == .Map ? "SelectICmap" : "ICmap"
            )
            
            }
            .tag(AppTap.Map)
            
            
            NavigationStack(path: $coordinator.pathColecao) {
                CollectionView()
                    .navigationDestination(for: AppRoute.self) { rota in
                        ViewFactory.viewBuilder(for: rota)
                            .toolbar(.hidden, for: .tabBar)
                    }
            }
            .tabItem { Label("Coleção",  image: coordinator.selectedView == .Collection ? "SelectICmagazine" : "ICmagazine")
                }
            .tag(AppTap.Collection)
        }
        .buttonStyle(.plain)
        .environment(coordinator)
        .onAppear {
                    let appearance = UITabBarAppearance()
                    appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.texIcon]
                    appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
                    UITabBar.appearance().standardAppearance = appearance
                }
     
    }
}
#Preview {
    CoordinatorView()
        .modelContainer(PreviewSupport.container)
        .environment(PreviewSupport.expeditionLog)
}
