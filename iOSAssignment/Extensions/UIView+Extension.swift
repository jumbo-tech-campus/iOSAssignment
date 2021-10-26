//
//  UIView+Extension.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 26/10/21.
//

import UIKit

// MARK: - General

extension UIView {
    
    @discardableResult func addView(_ view: UIView) -> UIView {
        addSubview(view)
        return self
    }
}
