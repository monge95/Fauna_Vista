//
//  SwiftDataTestView.swift
//  
//
//  Created by Gabriel Groppo on 28/09/26.
//


import SwiftUI
import SwiftData

struct SwiftDataTestView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack {
            Text("Teste SwiftData")
            
            Button("Salvar Tamanduá") {
                let animal = Animal(
                    taxonID: 123,
                    nomePopular: "Tamanduá-bandeira",
                    nomeCientifico: "Myrmecophaga tridactyla",
                    localizacao: "Cerrado",
                    statusConservacao: "Vulnerável"
                )
                
                modelContext.insert(animal)
            }
        }
    }
}
#Preview {
    SwiftDataTestView()
        .modelContainer(for: Animal.self)
}
