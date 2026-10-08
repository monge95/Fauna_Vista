//
//  CoordinatorView.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 28/09/26.
//
import SwiftUI
import SwiftData

struct CoordinatorView: View{
    @Environment(AppCoordinator.self) private var coordinator
    @Environment(\.modelContext) private var modelContext
   
    var body: some View{
        
        @Bindable var coordinator = coordinator
        
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
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.button]
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.button]
                    UITabBar.appearance().standardAppearance = appearance
        }
        .task {
            await initializeCatalog()
        }
     
    }
    private func initializeCatalog() async {
        let repository = AnimalRepository(
            modelContext: modelContext
        )

        let service = AnimalService(
            repository: repository
        )

        do {
            try await service.initializeCatalogIfNeeded()
        } catch {
            print("Error initializing catalog: \(error)")
        }
    }
}

#Preview {
    CoordinatorView()
        .modelContainer(PreviewSupport.container)
        .environment(PreviewSupport.expeditionLog)
}
