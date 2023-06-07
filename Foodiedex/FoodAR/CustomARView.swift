//
//  CustomARView.swift
//  Foodiedex
//
//  Created by Yathartha Regmi on 6/6/23.
//

import ARKit
import SwiftUI
import RealityKit

class CustomARView: ARView {
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
}
