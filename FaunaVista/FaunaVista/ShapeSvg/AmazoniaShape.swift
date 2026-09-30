//
//  AmazoniaShape.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 29/09/26.
//
import SwiftUI

struct AmazoniaShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Array com todos os pontos-chave do contorno da Amazônia.
        // O Swift processa isso instantaneamente, sem travar a compilação.
        let pontos: [CGPoint] = [
            CGPoint(x: 371.3, y: 93.5), CGPoint(x: 363.6, y: 96.3), CGPoint(x: 362.3, y: 104.9),
            CGPoint(x: 355.5, y: 107.3), CGPoint(x: 352.2, y: 119.0), CGPoint(x: 343.1, y: 120.7),
            CGPoint(x: 338.7, y: 131.0), CGPoint(x: 338.1, y: 131.5), CGPoint(x: 337.0, y: 132.2),
            CGPoint(x: 336.4, y: 132.5), CGPoint(x: 335.1, y: 132.9), CGPoint(x: 333.9, y: 132.3),
            CGPoint(x: 332.7, y: 131.8), CGPoint(x: 324.8, y: 130.8), CGPoint(x: 312.8, y: 130.8),
            CGPoint(x: 315.2, y: 135.2), CGPoint(x: 314.4, y: 136.4), CGPoint(x: 313.7, y: 137.6),
            CGPoint(x: 314.0, y: 143.6), CGPoint(x: 311.3, y: 154.8), CGPoint(x: 310.3, y: 158.8),
            CGPoint(x: 306.7, y: 160.0), CGPoint(x: 307.9, y: 173.2), CGPoint(x: 307.3, y: 176.9),
            CGPoint(x: 303.9, y: 178.1), CGPoint(x: 300.2, y: 167.9), CGPoint(x: 290.3, y: 178.9),
            CGPoint(x: 284.6, y: 192.5), CGPoint(x: 276.8, y: 192.9), CGPoint(x: 273.8, y: 199.1),
            CGPoint(x: 272.8, y: 199.8), CGPoint(x: 269.4, y: 201.0), CGPoint(x: 270.9, y: 203.5),
            CGPoint(x: 271.6, y: 209.2), CGPoint(x: 269.1, y: 222.2), CGPoint(x: 266.2, y: 232.8),
            CGPoint(x: 259.4, y: 230.5), CGPoint(x: 232.6, y: 229.4), CGPoint(x: 229.8, y: 231.6),
            CGPoint(x: 228.0, y: 228.8), CGPoint(x: 227.5, y: 226.8), CGPoint(x: 227.2, y: 226.2),
            CGPoint(x: 221.7, y: 219.2), CGPoint(x: 218.6, y: 217.0), CGPoint(x: 216.9, y: 214.5),
            CGPoint(x: 216.7, y: 214.3), CGPoint(x: 216.5, y: 214.2), CGPoint(x: 216.1, y: 214.2),
            CGPoint(x: 215.9, y: 214.2), CGPoint(x: 215.7, y: 214.3), CGPoint(x: 215.5, y: 214.5),
            CGPoint(x: 215.4, y: 214.5), CGPoint(x: 215.2, y: 214.7), CGPoint(x: 211.8, y: 226.5),
            CGPoint(x: 205.1, y: 231.9), CGPoint(x: 202.6, y: 234.1), CGPoint(x: 192.8, y: 224.6),
            CGPoint(x: 193.3, y: 219.0), CGPoint(x: 180.9, y: 206.6), CGPoint(x: 171.4, y: 208.5),
            CGPoint(x: 171.1, y: 208.9), CGPoint(x: 170.6, y: 209.6), CGPoint(x: 170.3, y: 210.4),
            CGPoint(x: 170.2, y: 210.8), CGPoint(x: 170.1, y: 211.6), CGPoint(x: 170.2, y: 212.3),
            CGPoint(x: 170.5, y: 214.3), CGPoint(x: 170.8, y: 215.7), CGPoint(x: 170.9, y: 217.1),
            CGPoint(x: 170.9, y: 217.3), CGPoint(x: 169.6, y: 225.3), CGPoint(x: 175.0, y: 231.6),
            CGPoint(x: 174.1, y: 236.2), CGPoint(x: 174.4, y: 239.9), CGPoint(x: 174.8, y: 241.1),
            CGPoint(x: 175.6, y: 242.8), CGPoint(x: 176.2, y: 243.9), CGPoint(x: 176.9, y: 245.0),
            CGPoint(x: 177.7, y: 246.1), CGPoint(x: 178.6, y: 247.0), CGPoint(x: 187.0, y: 250.7),
            CGPoint(x: 188.2, y: 250.3), CGPoint(x: 188.5, y: 250.1), CGPoint(x: 189.2, y: 249.6),
            CGPoint(x: 189.9, y: 249.0), CGPoint(x: 190.5, y: 248.2), CGPoint(x: 191.1, y: 247.4),
            CGPoint(x: 191.9, y: 246.0), CGPoint(x: 192.8, y: 244.1), CGPoint(x: 193.4, y: 242.9),
            CGPoint(x: 193.9, y: 242.1), CGPoint(x: 207.2, y: 237.5), CGPoint(x: 207.9, y: 249.5),
            CGPoint(x: 204.2, y: 253.9), CGPoint(x: 199.2, y: 262.6), CGPoint(x: 196.6, y: 261.3),
            CGPoint(x: 195.3, y: 258.4), CGPoint(x: 189.2, y: 259.7), CGPoint(x: 184.2, y: 258.0),
            CGPoint(x: 177.6, y: 266.9), CGPoint(x: 166.9, y: 266.4), CGPoint(x: 165.3, y: 256.1),
            CGPoint(x: 163.2, y: 251.5), CGPoint(x: 162.8, y: 237.8), CGPoint(x: 149.0, y: 233.3),
            CGPoint(x: 143.3, y: 229.1), CGPoint(x: 134.4, y: 225.2), CGPoint(x: 128.5, y: 221.8),
            CGPoint(x: 121.1, y: 220.0), CGPoint(x: 118.0, y: 219.9), CGPoint(x: 113.7, y: 216.9),
            CGPoint(x: 104.8, y: 206.8), CGPoint(x: 104.1, y: 204.3), CGPoint(x: 104.0, y: 186.1),
            CGPoint(x: 100.8, y: 186.2), CGPoint(x: 99.4, y: 186.0),  CGPoint(x: 83.6, y: 191.5),
            CGPoint(x: 76.6, y: 196.3),  CGPoint(x: 71.9, y: 197.4),  CGPoint(x: 49.0, y: 200.4),
            CGPoint(x: 40.6, y: 200.1),  CGPoint(x: 40.7, y: 183.0),  CGPoint(x: 31.0, y: 188.4),
            CGPoint(x: 22.1, y: 188.3),  CGPoint(x: 19.6, y: 182.4),  CGPoint(x: 9.6, y: 181.1),
            CGPoint(x: 12.0, y: 175.5),  CGPoint(x: 0.0, y: 157.0),   CGPoint(x: 2.0, y: 154.1),
            CGPoint(x: 10.8, y: 145.0),  CGPoint(x: 11.5, y: 135.2),  CGPoint(x: 13.4, y: 127.7),
            CGPoint(x: 24.9, y: 120.3),  CGPoint(x: 36.1, y: 117.9),  CGPoint(x: 48.5, y: 117.0),
            CGPoint(x: 49.2, y: 114.8),  CGPoint(x: 50.5, y: 106.8),  CGPoint(x: 55.0, y: 79.3),
            CGPoint(x: 53.6, y: 75.1),   CGPoint(x: 51.8, y: 70.0),   CGPoint(x: 47.4, y: 66.8),
            CGPoint(x: 47.4, y: 56.3),   CGPoint(x: 55.5, y: 54.1),   CGPoint(x: 54.8, y: 51.8),
            CGPoint(x: 50.4, y: 50.3),   CGPoint(x: 49.7, y: 45.8),   CGPoint(x: 50.6, y: 42.3),
            CGPoint(x: 53.3, y: 42.1),   CGPoint(x: 68.1, y: 42.2),   CGPoint(x: 70.0, y: 39.6),
            CGPoint(x: 79.6, y: 35.8),   CGPoint(x: 82.4, y: 40.3),   CGPoint(x: 84.4, y: 47.7),
            CGPoint(x: 98.5, y: 52.0),   CGPoint(x: 101.8, y: 51.3),  CGPoint(x: 102.6, y: 54.9),
            CGPoint(x: 112.3, y: 46.9),  CGPoint(x: 117.7, y: 44.4),  CGPoint(x: 119.8, y: 39.5),
            CGPoint(x: 125.5, y: 37.4),  CGPoint(x: 127.1, y: 34.8),  CGPoint(x: 124.3, y: 34.2),
            CGPoint(x: 120.5, y: 33.3),  CGPoint(x: 119.5, y: 29.4),  CGPoint(x: 117.0, y: 19.2),
            CGPoint(x: 110.4, y: 10.5),  CGPoint(x: 119.0, y: 12.5),  CGPoint(x: 121.9, y: 14.7),
            CGPoint(x: 130.9, y: 15.0),  CGPoint(x: 134.2, y: 18.5),  CGPoint(x: 140.4, y: 12.0),
            CGPoint(x: 152.2, y: 8.0),   CGPoint(x: 154.1, y: 7.7),   CGPoint(x: 156.0, y: 7.0),
            CGPoint(x: 159.0, y: 4.8),   CGPoint(x: 160.5, y: 1.4),   CGPoint(x: 164.5, y: 0.0),
            CGPoint(x: 168.6, y: 1.6),   CGPoint(x: 168.7, y: 6.9),   CGPoint(x: 174.1, y: 16.9),
            CGPoint(x: 171.5, y: 23.1),  CGPoint(x: 172.4, y: 36.4),  CGPoint(x: 175.4, y: 43.6),
            CGPoint(x: 185.0, y: 47.5),  CGPoint(x: 191.9, y: 43.5),  CGPoint(x: 198.2, y: 41.8),
            CGPoint(x: 217.6, y: 39.7),  CGPoint(x: 215.6, y: 35.0),  CGPoint(x: 218.9, y: 32.7),
            CGPoint(x: 233.3, y: 33.9),  CGPoint(x: 242.6, y: 34.7),  CGPoint(x: 250.3, y: 34.6),
            CGPoint(x: 257.9, y: 32.5),  CGPoint(x: 266.9, y: 15.9),  CGPoint(x: 271.2, y: 8.3),
            CGPoint(x: 277.9, y: 25.5),  CGPoint(x: 281.5, y: 35.5),  CGPoint(x: 286.6, y: 40.2),
            CGPoint(x: 291.3, y: 42.9),  CGPoint(x: 289.0, y: 54.7),  CGPoint(x: 289.9, y: 59.7),
            CGPoint(x: 295.4, y: 61.4),  CGPoint(x: 304.7, y: 66.7),  CGPoint(x: 308.8, y: 67.3),
            CGPoint(x: 311.1, y: 70.9),  CGPoint(x: 315.7, y: 70.9),  CGPoint(x: 325.2, y: 72.2),
            CGPoint(x: 332.9, y: 74.5),  CGPoint(x: 336.5, y: 76.0),  CGPoint(x: 343.5, y: 78.8),
            CGPoint(x: 351.0, y: 79.5),  CGPoint(x: 364.9, y: 92.4),  CGPoint(x: 371.3, y: 93.5)
        ]
        
        // Se houver pontos, o caminho inicia no primeiro e desenha linhas para todos os outros
        if let primeiroPonto = pontos.first {
            path.move(to: primeiroPonto)
            path.addLines(pontos)
        }
        
        path.closeSubpath()
        
        // Escalonamento para o tamanho do viewBox do SVG da Amazônia (372x267)
        let scaleX = rect.width / 372.0
        let scaleY = rect.height / 267.0
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        
        return path.applying(transform)
    }
}
