//
//  GradientLayer.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 19/12/2022.
//

import Foundation
import UIKit

public enum GradientDirection{
    case vertical
    case horizontal
    case diagonalDown
    case diagonalUp
    case radial
}

public extension UIView {
    
    // You might need to save reference to Gradient Layer to change frame on autoLayout
    func addGradientLayer(gradientColors: [CGColor], gradientDirection: GradientDirection) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.applyGradient(gradientColors: gradientColors, gradientDirection: gradientDirection)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
    
}

public extension CAGradientLayer {
    
    func applyGradient(gradientColors: [CGColor], gradientDirection: GradientDirection) {
        switch gradientDirection {
        case .horizontal:
            self.startPoint =  CGPoint.init(x: 0, y: 0)
            self.endPoint   =  CGPoint.init(x: 1, y: 0)
        case .vertical:
            self.startPoint =  CGPoint.init(x: 0, y: 0)
            self.endPoint   =  CGPoint.init(x: 0, y: 1)
        case .diagonalUp:
            self.startPoint =  CGPoint.init(x: 0, y: 1)
            self.endPoint   =  CGPoint.init(x: 1, y: 0)
        case .diagonalDown:
            self.startPoint =  CGPoint.init(x: 0, y: 0)
            self.endPoint   =  CGPoint.init(x: 1, y: 1)
        case .radial:
            self.type = .radial
            self.startPoint =  CGPoint.init(x: 1, y: 0.5)
            self.endPoint   =  CGPoint.init(x: 0, y: -0.5)
        }
        self.colors = gradientColors
    }
    
}
