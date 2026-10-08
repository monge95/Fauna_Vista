//
//  StructMap.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 30/09/26.
//

import SwiftUI

struct MapPiece: Identifiable {
        let id: Int
        let name: String
        let assetColorido: String
        let assetCinza: String
        let posX: CGFloat
        let posY: CGFloat
        let shape: AnyShape
        let border: String
  
    
    static let todosOsBiomas: [MapPiece] = [
        MapPiece(id: 2,name: "Amazônia", assetColorido: "Amazonia", assetCinza: "AmazoniaGrey", posX: 193.9, posY: 143.1, shape: AnyShape(AmazoniaShape()), border: "BorderAmazonia"),
        
        MapPiece(id: 3,name: "Pampa", assetColorido: "Pampa", assetCinza: "PampaGrey", posX: 250.9, posY: 459.1, shape: AnyShape(PampaShape()), border: "BorderPampa"),
        
        MapPiece(id: 5,name: "Caatinga", assetColorido: "Caatinga", assetCinza: "CaatingaGrey", posX: 422.4, posY: 190.1, shape: AnyShape(Rectangle()), border: "BorderCaatinga"),
        
        MapPiece(id: 4,name: "Mata Atlântica", assetColorido: "Mataatlantica", assetCinza: "MataatlanticaGrey", posX: 355.9, posY: 293.1, shape: AnyShape(MataAtlanticaShape()), border: "BorderMataaclantica"),
        
        MapPiece(id: 6,name: "Pantanal", assetColorido: "Pantanal", assetCinza: "PantanalGrey", posX: 213.4, posY: 309.1, shape: AnyShape(Rectangle()), border: "BorderPantanal"),
        
        MapPiece(id: 1,name: "Cerrado", assetColorido: "Cerrado", assetCinza: "CerradoGrey", posX: 289.1, posY: 241.94, shape: AnyShape(CerradoShape()), border: "BordaCerrado")
        ]
}
