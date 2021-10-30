//
//  Int+Extension.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 30/10/21.
//

import Foundation

extension Int {

    func toCurrency(locale: Locale = Locale.autoupdatingCurrent, symbol: Symbol = .unowned) -> String {
        let currencyFormatter = Formater(locale: locale).currency(symbol: symbol)
        let amount = Double(self) * 0.01
        return currencyFormatter.string(from: NSNumber(value: amount)) ?? ""
    }
}
