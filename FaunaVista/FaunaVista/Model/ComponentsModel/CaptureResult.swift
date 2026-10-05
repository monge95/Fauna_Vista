//
//  CaptureResult.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
//
import SwiftUI
import UIKit
import RealityKit
import Combine

struct CaptureResult {
    let image: UIImage
    let stars: Int
    let objectName: String
    let distance: Float?
    let isScorable: Bool
    let animalID: String?
    let pose: ExpeditionAnimalPose?
}
