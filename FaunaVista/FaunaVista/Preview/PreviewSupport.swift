//
//  PreviewSupport.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 01/10/26.
//
import SwiftData

enum PreviewSupport {

    @MainActor
    static var container: ModelContainer {
        do {
            let configuration = ModelConfiguration(
                isStoredInMemoryOnly: true
            )

            return try ModelContainer(
                for:
                    Animal.self,
                    Expedition.self,
                    ExpeditionPhoto.self,
                configurations: configuration
            )
        } catch {
            fatalError(
                "Failed to create preview ModelContainer: \(error)"
            )
        }
    }

    @MainActor
    static var expeditionLog: ExpeditionLog {
        ExpeditionLog()
    }

    @MainActor
    static var coordinator: AppCordinator {
        AppCordinator()
    }
}
