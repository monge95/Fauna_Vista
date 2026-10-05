//
//  Untitled.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 30/09/26.
//

import SwiftUI

struct MataAtlanticaShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Array com todos os pontos-chave do contorno da Mata Atlântica.
        // O Swift processa isso instantaneamente, sem travar a compilação.
        let pontos: [CGPoint] = [
            CGPoint(x: 66.6, y: 310.1), CGPoint(x: 68.1, y: 305.6), CGPoint(x: 57.7, y: 306.3),
            CGPoint(x: 51.3, y: 302.9), CGPoint(x: 36.0, y: 305.9), CGPoint(x: 24.4, y: 304.0),
            CGPoint(x: 6.7, y: 300.2),  CGPoint(x: 25.6, y: 301.4), CGPoint(x: 29.1, y: 294.1),
            CGPoint(x: 12.6, y: 286.9), CGPoint(x: 5.1, y: 284.4),  CGPoint(x: 7.6, y: 281.1),
            CGPoint(x: 12.1, y: 277.9), CGPoint(x: 23.5, y: 271.4), CGPoint(x: 23.9, y: 261.7),
            CGPoint(x: 21.3, y: 254.3), CGPoint(x: 13.0, y: 254.5), CGPoint(x: 17.1, y: 239.0),
            CGPoint(x: 15.1, y: 233.1), CGPoint(x: 2.8, y: 233.2),  CGPoint(x: 0.0, y: 216.1),
            CGPoint(x: 3.8, y: 214.2),  CGPoint(x: 7.5, y: 205.9),  CGPoint(x: 12.4, y: 205.5),
            CGPoint(x: 22.6, y: 206.3), CGPoint(x: 38.0, y: 207.3), CGPoint(x: 45.6, y: 195.4),
            CGPoint(x: 51.1, y: 187.1), CGPoint(x: 52.4, y: 186.1), CGPoint(x: 54.0, y: 186.0),
            CGPoint(x: 54.9, y: 185.2), CGPoint(x: 54.9, y: 177.5), CGPoint(x: 58.0, y: 173.8),
            CGPoint(x: 57.5, y: 172.0), CGPoint(x: 56.7, y: 170.3), CGPoint(x: 56.6, y: 168.9),
            CGPoint(x: 56.0, y: 168.7), CGPoint(x: 56.6, y: 166.2), CGPoint(x: 59.3, y: 165.9),
            CGPoint(x: 63.9, y: 161.2), CGPoint(x: 68.2, y: 161.9), CGPoint(x: 70.4, y: 164.1),
            CGPoint(x: 71.8, y: 162.3), CGPoint(x: 71.9, y: 161.2), CGPoint(x: 75.1, y: 161.1),
            CGPoint(x: 77.4, y: 165.5), CGPoint(x: 78.0, y: 159.5), CGPoint(x: 78.8, y: 159.7),
            CGPoint(x: 81.4, y: 157.6), CGPoint(x: 84.0, y: 157.5), CGPoint(x: 86.6, y: 161.4),
            CGPoint(x: 87.3, y: 164.9), CGPoint(x: 79.4, y: 166.6), CGPoint(x: 77.7, y: 170.1),
            CGPoint(x: 77.4, y: 171.1), CGPoint(x: 76.0, y: 171.3), CGPoint(x: 75.6, y: 170.2),
            CGPoint(x: 74.1, y: 166.4), CGPoint(x: 61.4, y: 176.8), CGPoint(x: 60.9, y: 180.5),
            CGPoint(x: 73.6, y: 180.1), CGPoint(x: 76.7, y: 182.7), CGPoint(x: 76.2, y: 186.7),
            CGPoint(x: 65.6, y: 190.7), CGPoint(x: 76.0, y: 192.6), CGPoint(x: 80.5, y: 192.7),
            CGPoint(x: 79.7, y: 186.6), CGPoint(x: 85.5, y: 198.6), CGPoint(x: 79.0, y: 201.6),
            CGPoint(x: 86.5, y: 214.8), CGPoint(x: 78.9, y: 207.7), CGPoint(x: 76.1, y: 213.5),
            CGPoint(x: 64.7, y: 213.0), CGPoint(x: 56.2, y: 208.5), CGPoint(x: 52.7, y: 215.5),
            CGPoint(x: 69.8, y: 218.6), CGPoint(x: 75.4, y: 219.8), CGPoint(x: 76.4, y: 224.8),
            CGPoint(x: 63.5, y: 238.9), CGPoint(x: 65.8, y: 242.7), CGPoint(x: 69.0, y: 240.4),
            CGPoint(x: 81.4, y: 236.5), CGPoint(x: 86.7, y: 233.0), CGPoint(x: 93.7, y: 230.0),
            CGPoint(x: 93.0, y: 226.5), CGPoint(x: 89.9, y: 224.4), CGPoint(x: 96.6, y: 219.0),
            CGPoint(x: 98.0, y: 213.8), CGPoint(x: 100.8, y: 218.4), CGPoint(x: 105.6, y: 217.4),
            CGPoint(x: 108.4, y: 195.0), CGPoint(x: 123.4, y: 198.4), CGPoint(x: 124.2, y: 188.0),
            CGPoint(x: 126.2, y: 185.8), CGPoint(x: 128.3, y: 188.1), CGPoint(x: 133.1, y: 189.5),
            CGPoint(x: 134.9, y: 182.6), CGPoint(x: 137.8, y: 182.9), CGPoint(x: 148.2, y: 182.0),
            CGPoint(x: 148.6, y: 172.8), CGPoint(x: 146.8, y: 167.2), CGPoint(x: 155.6, y: 158.5),
            CGPoint(x: 158.2, y: 155.4), CGPoint(x: 162.7, y: 156.1), CGPoint(x: 162.5, y: 140.2),
            CGPoint(x: 161.9, y: 132.7), CGPoint(x: 166.0, y: 134.8), CGPoint(x: 168.4, y: 132.9),
            CGPoint(x: 163.5, y: 127.2), CGPoint(x: 158.8, y: 122.5), CGPoint(x: 167.1, y: 121.7),
            CGPoint(x: 178.6, y: 116.2), CGPoint(x: 187.2, y: 105.1), CGPoint(x: 183.9, y: 103.4),
            CGPoint(x: 183.6, y: 100.9), CGPoint(x: 189.5, y: 98.0), CGPoint(x: 194.4, y: 93.8),
            CGPoint(x: 198.9, y: 89.8),  CGPoint(x: 196.4, y: 83.6),  CGPoint(x: 204.4, y: 87.6),
            CGPoint(x: 205.6, y: 83.7),  CGPoint(x: 208.6, y: 84.1),  CGPoint(x: 215.0, y: 80.6),
            CGPoint(x: 217.3, y: 73.3),  CGPoint(x: 220.3, y: 68.1),  CGPoint(x: 222.7, y: 60.7),
            CGPoint(x: 224.9, y: 60.1),  CGPoint(x: 229.6, y: 62.4),  CGPoint(x: 234.1, y: 59.8),
            CGPoint(x: 229.0, y: 60.0),  CGPoint(x: 231.5, y: 51.9),  CGPoint(x: 229.2, y: 45.8),
            CGPoint(x: 241.0, y: 38.8),  CGPoint(x: 241.3, y: 36.0),  CGPoint(x: 243.4, y: 34.0),
            CGPoint(x: 247.6, y: 29.2),  CGPoint(x: 243.3, y: 27.7),  CGPoint(x: 245.9, y: 12.9),
            CGPoint(x: 244.9, y: 0.0),   CGPoint(x: 247.3, y: 1.2),   CGPoint(x: 248.0, y: 3.7),
            CGPoint(x: 252.0, y: 19.2),  CGPoint(x: 240.1, y: 59.1),  CGPoint(x: 227.8, y: 70.7),
            CGPoint(x: 209.2, y: 97.5),  CGPoint(x: 203.5, y: 103.1), CGPoint(x: 202.1, y: 117.5),
            CGPoint(x: 203.3, y: 133.7), CGPoint(x: 199.8, y: 157.3), CGPoint(x: 194.6, y: 162.4),
            CGPoint(x: 194.4, y: 177.8), CGPoint(x: 189.3, y: 183.1), CGPoint(x: 184.6, y: 192.7),
            CGPoint(x: 178.1, y: 203.5), CGPoint(x: 178.2, y: 209.5), CGPoint(x: 165.8, y: 221.3),
            CGPoint(x: 145.9, y: 222.7), CGPoint(x: 138.8, y: 224.3), CGPoint(x: 136.1, y: 224.5),
            CGPoint(x: 134.0, y: 226.2), CGPoint(x: 128.4, y: 228.1), CGPoint(x: 126.5, y: 233.6),
            CGPoint(x: 117.9, y: 232.0), CGPoint(x: 109.7, y: 236.6), CGPoint(x: 100.9, y: 242.8),
            CGPoint(x: 87.5, y: 256.6),  CGPoint(x: 87.4, y: 263.4),  CGPoint(x: 86.8, y: 271.7),
            CGPoint(x: 88.7, y: 277.9),  CGPoint(x: 84.8, y: 291.1),  CGPoint(x: 66.6, y: 310.0),
            CGPoint(x: 66.6, y: 310.1)
        ]
        
        // Desenha todas as linhas conectando os pontos da borda leste (oceano) até as extremidades com o Cerrado
        if let primeiroPonto = pontos.first {
            path.move(to: primeiroPonto)
            path.addLines(pontos)
        }
        
        path.closeSubpath()
        
        // Escalonamento para o tamanho do viewBox do SVG da Mata Atlântica (254x311)
        let scaleX = rect.width / 254.0
        let scaleY = rect.height / 311.0
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        
        return path.applying(transform)
    }
}
