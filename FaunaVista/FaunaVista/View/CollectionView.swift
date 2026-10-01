//
//  collection.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 28/09/26.
//

import SwiftUI

struct ColecaoView: View {
    @Environment(AppCordinator.self) private var coordinator
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "books.vertical.fill")
                .font(.system(size: 60))
                .foregroundColor(.brown)
            
            Text("Tela Base da Coleção")
                .font(.title)
                .bold()
        }
    }
}

