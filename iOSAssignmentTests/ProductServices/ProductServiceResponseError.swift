//
//  ProductServiceResponseError.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 31/10/21.
//

import Foundation

final class ProductServiceResponseError: ProductServicesProtocol {

    // MARK: - Custom methods

    func requestAllProducts(_ completion: @escaping CompletionProductList) {
        let products = JSONResponse.getProductsResponseError()
        let network = AFMock(data: products)
        let requester = ProductResourcesTestable.requestAllProducts
        network.makeRequest(requester: requester) { (response: Response<Products>) in
            completion(response)
        }
    }
}
