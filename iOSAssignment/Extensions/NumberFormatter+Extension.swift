//
//  NumberFormatter+Extension.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 30/10/21.
//

import Foundation

extension NumberFormatter {

    static let baseFormatter: NumberFormatter  = {
        $0.numberStyle = .currency
        $0.roundingMode = .down
        return $0
    }(NumberFormatter())
}
