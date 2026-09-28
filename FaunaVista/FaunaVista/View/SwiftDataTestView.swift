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
    @Query private var animais: [Animal]
    
    var body: some View {
        VStack {
            Text("Teste SwiftData")
                .font(.title)
            
            Button("Salvar Tamanduá") {
                salvarAnimal()
            }
            
            Button("Buscar e salvar Tamanduá") {
                Task {
                    do {
                        let service = INaturalistService()

                        if let taxon = try await service.buscarAnimal(
                            nomeCientifico: "Myrmecophaga tridactyla"
                        ) {
                            try salvarTaxon(
                                taxon,
                                localizacao: "Cerrado"
                            )
                        } else {
                            print("Animal não encontrado.")
                        }

                    } catch {
                        print("Erro: \(error)")
                    }
                }
            }
            
            Text("Animais salvos: \(animais.count)")
            
            List(animais) { animal in
                VStack(alignment: .leading) {
                    Text(animal.nomePopular)
                        .font(.headline)

                    Text(animal.nomeCientifico)
                        .italic()

                    Text(animal.localizacao)

                    Text(animal.statusConservacao)

                    Button("Deletar") {
                        deletarAnimal(animal)
                    }
                }
            }
        }
    }
    private func salvarAnimal() {

        let taxonID = 123

        var descriptor = FetchDescriptor<Animal>(
            predicate: #Predicate { animal in
                animal.taxonID == taxonID
            }
        )

        descriptor.fetchLimit = 1

        do {
            let animaisEncontrados = try modelContext.fetch(descriptor)

            if let animalExistente = animaisEncontrados.first {

                animalExistente.nomePopular = "Tamanduá-bandeira"
                animalExistente.nomeCientifico = "Myrmecophaga tridactyla"
                animalExistente.localizacao = "Cerrado"
                animalExistente.statusConservacao = "Vulnerável"

                print("Animal atualizado!")

            } else {

                let novoAnimal = Animal(
                    taxonID: taxonID,
                    nomePopular: "Tamanduá-bandeira",
                    nomeCientifico: "Myrmecophaga tridactyla",
                    localizacao: "Cerrado",
                    statusConservacao: "Vulnerável"
                )

                modelContext.insert(novoAnimal)

                print("Animal criado!")
            }

        } catch {
            print("Erro ao salvar animal: \(error)")
        }
    }
    private func deletarAnimal(_ animal: Animal) {
        modelContext.delete(animal)
        print("Animal deletado!")
    }
    
    private func salvarTaxon(
        _ taxon: INaturalistTaxon,
        localizacao: String
    ) throws {
        
        let taxonID = taxon.id
        
        var descriptor = FetchDescriptor<Animal>(
            predicate: #Predicate { animal in
                animal.taxonID == taxonID
            }
        )
        
        descriptor.fetchLimit = 1
        
        let animaisEncontrados = try modelContext.fetch(descriptor)
        
        if let animalExistente = animaisEncontrados.first {
            
            animalExistente.nomePopular =
                taxon.preferredCommonName ?? "Nome não informado"
            
            animalExistente.nomeCientifico = taxon.name
            
            animalExistente.statusConservacao =
                taxon.conservationStatus?.statusName ?? "Não informado"
            
            animalExistente.localizacao = localizacao
            
            print("Animal atualizado!")
            
        } else {
            
            let novoAnimal = Animal(
                taxonID: taxon.id,
                nomePopular: taxon.preferredCommonName ?? "Nome não informado",
                nomeCientifico: taxon.name,
                localizacao: localizacao,
                statusConservacao:
                    taxon.conservationStatus?.statusName ?? "Não informado"
            )
            
            modelContext.insert(novoAnimal)
            
            print("Animal criado!")
        }
    }
}
#Preview {
    SwiftDataTestView()
        .modelContainer(for: Animal.self)
}
