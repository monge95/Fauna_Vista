//  Created by Felipe Colares Cardoso on 05/10/26.
//

//
//  VegetationPalette.swift
//  FaunaVista
//
//  Catálogo de modelos 3D de vegetação + paleta por fase.
//

import Foundation

// MARK: - Tipo

enum VegetationKind {
    case tree
    case grass
}

// MARK: - Catálogo de modelos
// O rawValue é o nome do .usdz no bundle (sem extensão).
// Para adicionar um modelo novo: 1) arraste o .usdz pro projeto
// 2) crie um case aqui 3) classifique em `kind` 4) coloque nas paletas.

enum VegetationModel: String, CaseIterable, Identifiable {

    // CERRADO
    case gramaCerrado                               // arquivo: gramaCerrado.usdz
    case arvoreCerrado1 = "arvorecerrado1"
    case gramaPantanal = "gramaPantanal"
    case gramaCaatinga = "gramaCaatinga"
    case cactoCaatinga = "cactoCaatinga"
    // arquivo: arvorecerrado1.usdz
    // case gramaCerrado2
    // case arvoreCerrado2 = "arvorecerrado2"
    // case arbustoCerrado

    // AMAZÔNIA
    // case gramaAmazonia
    // case arvoreAmazonia1, arvoreAmazonia2, palmeiraAmazonia

    // PAMPA / MATA ATLÂNTICA / CAATINGA / PANTANAL ...

    var id: String { rawValue }
    var fileName: String { rawValue }

    var kind: VegetationKind {
        switch self {
        case .gramaCerrado:
            return .grass
        case .arvoreCerrado1:
            return .tree
        case .gramaPantanal:
            return .grass
        case .gramaCaatinga:
            return .grass
        case .cactoCaatinga:
            return .tree

        // case .gramaCerrado2, .gramaAmazonia: return .grass
        // case .arvoreCerrado2, .arvoreAmazonia1, ...: return .tree
        }
    }

    /// Debug: avisa no console se algum modelo do catálogo não está no bundle.
    static func validateBundle() {
        #if DEBUG
        for model in allCases where Bundle.main.url(forResource: model.fileName, withExtension: "usdz") == nil {
            print("⚠️ VegetationModel: \(model.fileName).usdz nã bo encontrado no bundle")
        }
        #endif
    }
}

// MARK: - Paleta (o que uma fase pode usar)

struct VegetationPalette {
    var trees: [VegetationModel]
    var grasses: [VegetationModel]

    /// Quais Vegetacao_N do Blender são árvore; os demais são grama/arbusto.
    var treeSlots: Set<Int> = [2, 6, 11, 15]

    /// Força um modelo específico num slot (ignora o sorteio).
    var slotOverrides: [Int: VegetationModel] = [:]

    // Para o preload do cache.
    var allModelNames: [String] {
        let all = trees + grasses + Array(slotOverrides.values)
        return Array(Set(all.map(\.fileName)))
    }

    /// Escolhe o modelo do slot de forma determinística:
    /// - árvores e gramas são distribuídas em rodízio (todas as variações aparecem);
    /// - o `seed` (id da fase) muda o ponto de partida, então cada fase fica diferente,
    ///   mas o resultado é sempre o mesmo a cada execução.
    func model(forSlot slot: Int, seed: String) -> VegetationModel? {
        if let forced = slotOverrides[slot] { return forced }

        let isTree = treeSlots.contains(slot)
        let pool = isTree ? trees : grasses
        guard !pool.isEmpty else { return nil }

        let rank: Int
        if isTree {
            rank = treeSlots.filter { $0 < slot }.count
        } else {
            rank = (slot - 1) - treeSlots.filter { $0 < slot }.count
        }

        let offset = Int(Self.stableHash(seed) % UInt64(pool.count))
        return pool[(rank + offset) % pool.count]
    }

    // FNV-1a (hashValue do Swift muda a cada execução, esse não).
    private static func stableHash(_ string: String) -> UInt64 {
        var hash: UInt64 = 0xcbf29ce484222325
        for byte in string.utf8 {
            hash ^= UInt64(byte)
            hash = hash &* 0x100000001b3
        }
        return hash
    }

    // Helpers para ajustar uma paleta base por mapa.
    func withTreeSlots(_ slots: Set<Int>) -> VegetationPalette {
        var copy = self; copy.treeSlots = slots; return copy
    }
    func withOverrides(_ overrides: [Int: VegetationModel]) -> VegetationPalette {
        var copy = self; copy.slotOverrides = overrides; return copy
    }
}

// MARK: - Paletas por bioma

extension VegetationPalette {
    static let cerrado = VegetationPalette(
        trees:   [.arvoreCerrado1 /*, .arvoreCerrado2 */],
        grasses: [.gramaCerrado   /*, .gramaCerrado2, .arbustoCerrado */]
    )
    static let pantanal = VegetationPalette(
        trees: [.arvoreCerrado1],
        grasses: [.gramaPantanal]
    )
    static let caatinga = VegetationPalette(
        trees: [.cactoCaatinga],
        grasses: [.gramaCaatinga]
    )

    // static let amazonia = VegetationPalette(
    //     trees:   [.arvoreAmazonia1, .arvoreAmazonia2, .palmeiraAmazonia],
    //     grasses: [.gramaAmazonia]
    // )
    // static let pampa, mataAtlantica, caatinga, pantanal
}
