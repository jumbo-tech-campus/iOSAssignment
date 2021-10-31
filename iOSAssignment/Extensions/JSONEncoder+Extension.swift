//
//  JSONEncoder+Extension.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 30/10/21.
//

import Foundation

extension JSONEncoder {

    static let encoder: JSONEncoder = {
        $0.dateEncodingStrategy = .formatted(.dateFormatterReveiced)
        return $0
    }(JSONEncoder())
}
