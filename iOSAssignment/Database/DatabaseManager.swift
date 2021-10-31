//
//  DatabaseManager.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 30/10/21.
//

import Foundation

final class DatabaseManager: DatabaseProtocol {

    // MARK: - Attributes

    private let database: UserDefaults

    // MARK: - Life cycle

    init(database: UserDefaults = .standard) {
        self.database = database
    }

    // MARK: - Custom methods

    @discardableResult func save<T: ObjectRepresentable>(model: T) throws -> T {
        let object = try JSONEncoder.encoder.encode(model)
        database.setValue(object, forKey: T.key)
        return model
    }

    func loadObject<T: ObjectRepresentable>(type: T.Type) throws -> T? {
        guard let object = database.data(forKey: type.key) else { return nil }
        let model = try JSONDecoder.decoder.decode(T.self, from: object)
        return model
    }
}
