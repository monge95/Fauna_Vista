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
            .tabItem { Label("Mapa", systemImage: "map.fill") }
            .tag(AppTap.Map)
            
            
            NavigationStack(path: $coordinator.pathColecao) {
                CollectionView()
                    .navigationDestination(for: AppRoute.self) { rota in
                        ViewFactory.viewBuilder(for: rota)
                            .toolbar(.hidden, for: .tabBar)
                    }
            }
            .tabItem { Label("Coleção", systemImage: "magazine") }
            .tag(AppTap.Collection)
        }
        .environment(coordinator)
     
    }
}
#Preview {
    CoordinatorView()
        .modelContainer(PreviewSupport.container)
        .environment(PreviewSupport.expeditionLog)
}
