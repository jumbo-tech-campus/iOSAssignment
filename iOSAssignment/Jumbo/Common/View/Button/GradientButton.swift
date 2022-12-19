//
//  GradientButton.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 19/12/2022.
//

import Foundation
import UIKit

open class GradientButton: UIButton {

    open override func awakeFromNib() {
        super.awakeFromNib()
        setNeedsDisplay()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsDisplay()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setNeedsDisplay()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }
    
    open override func setNeedsDisplay() {
        super.setNeedsDisplay()
        styleGradient()
    }
    
    // MARK:- Private functions
    private var gradientLayer = CAGradientLayer()
    
    
    private func styleGradient() {
            if gradientLayer.superlayer == nil {
                self.layer.insertSublayer(gradientLayer, at: 0)
            }
            
            gradientLayer.isHidden = false
            var colors: [CGColor] = []
                    colors = [UIColor(hex: "#b51b57").cgColor,
                              UIColor(hex: "#ff5858").cgColor]
            gradientLayer.applyGradient(gradientColors: colors, gradientDirection: GradientDirection.diagonalDown)
        gradientLayer.frame = self.bounds
        }
    
}
