//
//  DateFormatter+Extension.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

import Foundation

extension DateFormatter {

    static let dateFormatterReveiced: DateFormatter = {
        $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // TODO: handle date format form server
        return $0
    }(DateFormatter())

    static let dateFormatterShow: DateFormatter = {
        $0.locale = Locale.current
        $0.timeZone = .current
        return $0
    }(DateFormatter())
}
