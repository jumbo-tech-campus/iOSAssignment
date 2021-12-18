//
//  UIView.swift
//  iOSAssignment
//
//  Created by David Velarde on 18/12/2021.
//

import UIKit

extension UIView {
    func addSubviewForAutolayout(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }
}
