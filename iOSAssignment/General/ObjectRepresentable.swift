//
//  ObjectRepresentable.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 30/10/21.
//

import Foundation

protocol ObjectRepresentable: Codable {
    static var key: String { get }
}
