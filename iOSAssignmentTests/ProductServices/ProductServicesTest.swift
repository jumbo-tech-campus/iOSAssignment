//
//  ProductServicesTest.swift
//  iOSAssignmentTests
//
//  Created by Jader Nunes on 31/10/21.
//

import Foundation
import Alamofire

final class ProductServicesTest: ProductServices {

    // MARK: - Attributes

    private let networkManager: NetworkManagerProtocol

    // MARK: - Life cycle

    override init(networkManager: NetworkManagerProtocol = AF) {
        self.networkManager = networkManager
    }

    override func requestAllProducts(_ completion: @escaping CompletionProductList) {
        let request = ProductResources.requestAllProducts
        networkManager.makeRequest(requester: request, completion)
    }
}
