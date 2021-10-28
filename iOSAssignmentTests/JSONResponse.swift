//
//  JSONResponse.swift
//  iOSAssignmentTests
//
//  Created by Jader Nunes on 27/10/21.
//

enum JSONFiles: String {
    case productsResult
}

struct JSONResponse {

    // MARK: - Attributes

    private static let decoder = FileDecoder()

    // MARK: - Life cycle

    private init() {}

    // MARK: - Responses

    static func getProductsResponse() -> Products? {
        decoder.decode(resource: .productsResult)
    }
}
