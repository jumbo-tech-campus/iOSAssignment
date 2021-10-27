//
//  UIColor+Extension.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

import UIKit

extension UIColor {

    // MARK: - Custom colors

    static let clGray = gray
    static let clSecondary = white
    static let clSeparator = lightGray
    static let clNoData = lightGray.withAlphaComponent(0.3)

    /// HEX: #F8C432
    static let clPrimary = UIColor(named: "primary") ?? white
}
