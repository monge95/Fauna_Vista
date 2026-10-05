//
//  ExpeditionDisplayLinkProxy.swift
//  Experiment Project
//
//  Created by Felipe Colares Cardoso on 01/10/26.
import SwiftUI
import UIKit
import RealityKit
import Combine



@MainActor
final class ExpeditionDisplayLinkProxy: NSObject {
    weak var target: ExpeditionSceneView?

    init(target: ExpeditionSceneView) {
        self.target = target
    }

    @objc func step(_ link: CADisplayLink) {
        target?.updateFrame()
    }
}
