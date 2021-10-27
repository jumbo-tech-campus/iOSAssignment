//
//  JSONDecoder+Extension.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

import Foundation

extension JSONDecoder {

    static let decoder: JSONDecoder = {
        $0.dateDecodingStrategy = .formatted(.dateFormatterReveiced)
        return $0
    }(JSONDecoder())
}
