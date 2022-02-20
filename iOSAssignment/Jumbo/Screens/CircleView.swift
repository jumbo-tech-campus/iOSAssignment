//
//  CircleView.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 16/02/22.
//

import UIKit

@IBDesignable
class CircleView: UIView {

    override func prepareForInterfaceBuilder() {
        layoutSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width / 2
        layer.masksToBounds = true
    }

}
