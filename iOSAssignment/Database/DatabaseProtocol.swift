//
//  DatabaseProtocol.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 30/10/21.
//

import Foundation

protocol DatabaseProtocol {
    @discardableResult func save<T: ObjectRepresentable>(model: T) throws -> T
    func loadObject<T: ObjectRepresentable>(type: T.Type) throws -> T?
}
