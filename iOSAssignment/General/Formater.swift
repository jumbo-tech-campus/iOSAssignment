//
//  Formater.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 30/10/21.
//

import Foundation

/// - Parameter locale: It's an optional. Default value is: autoupdatingCurrent.
final class Formater {

    // MARK: - Attributes

    private var localeDefault: Locale

    // MARK: - Life cycle

    /// Used to set a default formatter in a whole application. Default value is: autoupdatingCurrent.
    /// - Parameter locale: It's an optional.
    public init(locale: Locale = Locale.autoupdatingCurrent) {
        localeDefault = locale
    }

    // MARK: - Custom methods

    /// Used to format currecy with symbol
    /// - Parameter symbol: It's an optional. Default value is: "".
    func currency(symbol: Symbol = .unowned) -> NumberFormatter {
        let numberFormatter: NumberFormatter = .baseFormatter
        numberFormatter.locale = localeDefault
        numberFormatter.currencySymbol = symbol.value()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }
}
