//
//  ExpeditionLog.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 29/09/26.
//

import SwiftUI
import Observation

@Observable
class ExpeditionLog{
    
    var activeBiomeId: Int?
    
    var activeMissionId: Int?
    var activeScientificName: String?
    
    
    var capturedPhotos: [RegistroFotografico] = []
    
    var MissionAccomplished: Bool = false
    
    
    
    func AddPhoto(registroFotografico:RegistroFotografico) {
        if capturedPhotos.count < 10 {
            capturedPhotos.append(registroFotografico)
                }
        }
    
    func selectPhoto(idsSelecionados: [UUID]) {
        capturedPhotos.removeAll{ Photo in
            !idsSelecionados.contains(Photo.Id)
        }
    }
}

struct RegistroFotografico{
    let Id: UUID = UUID()
    let imagem: Data
    let nota: Int
}
