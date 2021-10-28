//
//  ProductServices.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

import Alamofire

typealias CompletionProductList = ((Response<Products>) -> Void)

protocol ProductServicesProtocol: AnyObject {
    func requestAllProducts(_ completion: @escaping CompletionProductList)
}

final class ProductServices: ProductServicesProtocol {

    // MARK: - Attributes

    private let networkManager: NetworkManagerProtocol

    // MARK: - Life cycle

    init(networkManager: NetworkManagerProtocol = AF) {
        self.networkManager = networkManager
    }

    // MARK: - Requests

    func requestAllProducts(_ completion: @escaping CompletionProductList) {
        guard
            let response = JSONResponse.getProductsResponse() else {
            completion(.failure(error: .generic()))
            return
        }

        completion(.success(response))

        /*
            TODO: Handle below when we'll have a real request

            let request = ProductResources.requestAllProducts
            networkManager.makeRequest(requester: request, completion)
        */
    }
}
