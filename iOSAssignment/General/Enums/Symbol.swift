//
//  Symbol.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 30/10/21.
//

import Foundation

enum Symbol: String {
    case euro = "EUR", unowned

    init(value: String) {
        self = Symbol(rawValue: value) ?? .unowned
    }

    func value() -> String {
        switch self {
            case .euro: return "€"
            case .unowned: return ""

        }
    }
}
