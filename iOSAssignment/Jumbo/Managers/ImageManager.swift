//
//  ImageManager.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 16/02/22.
//

import Foundation

class ImageManager {

    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func download(url: URL) async throws -> Data {
        // a cache here would really improve performance
        let (data, response) = try await session.data(from: url)

        guard (200...299).contains(response.statusCode) else {
            // a deeper error handling is needed
            throw URLError(.badServerResponse)
        }

        return data
    }

}
