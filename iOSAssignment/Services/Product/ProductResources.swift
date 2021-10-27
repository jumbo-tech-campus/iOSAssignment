//
//  ProductResources.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

import Alamofire

enum ProductResources {
    case requestAllProducts
}

extension ProductResources: Requestable {

    var method: HTTPMethodType { .get }
    var path: String { "/products" } //TODO: handle correct endpoint when exist
}
