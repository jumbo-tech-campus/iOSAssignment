//
//  AFMock.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 31/10/21.
//

import Foundation

final class AFMock<T: Decodable>: NetworkManagerProtocol {

    // MARK: - Attributes

    private let data: T?

    // MARK: - Life cycle

    init(data: T) {
        self.data = data
    }

    // MARK: - Custom methods

    func makeRequest<T: Decodable>(requester: Requestable,
                                   _ completion: @escaping CompletionRequest<T>) {
        guard
            let data = data as? T
            else {
                completion(.failure(error: .generic()))
            return
        }
        completion(.success(data))
    }
}
