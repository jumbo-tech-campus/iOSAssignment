//
//  Requestable.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

import Foundation
import Alamofire

typealias RequestParameters = [String: Any]
protocol Requestable: URLRequestConvertible {
    var method: HTTPMethodType { get }
    var parameters: RequestParameters? { get }
    var path: String { get }

    func asURLRequest() throws -> URLRequest
}

extension Requestable {

    // MARK: - Attributes

    var parameters: Parameters? { nil }

    // MARK: - Custom methods

    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: Config.baseURL) else {
            throw AFError.parameterEncodingFailed(reason: .missingURL)
        }

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        if let parameters = parameters {
            do {
                switch method {
                    case .get:
                        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
                    case .post, .patch, .delete:
                        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                }
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }
}
