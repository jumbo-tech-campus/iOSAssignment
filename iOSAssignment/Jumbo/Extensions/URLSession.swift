//
//  URLSession.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 17/02/22.
//

import Foundation

extension URLSession {
    @available(iOS, deprecated: 15.0, message: "This extension is no longer necessary. Use API built into SDK")
    func data(from url: URL) async throws -> (Data, HTTPURLResponse) {

        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: url) { data, response, error in
                guard let data = data,
                      let response = response as? HTTPURLResponse else {
                          let error = error ?? URLError(.badServerResponse)
                          return continuation.resume(throwing: error)
                      }

                continuation.resume(returning: (data, response))
            }

            task.resume()
        }
    }
}
