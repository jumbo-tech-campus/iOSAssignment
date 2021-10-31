//
//  ProductResourcesTestable.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 31/10/21.
//

import Foundation

enum ProductResourcesTestable {
    case requestAllProducts
}

extension ProductResourcesTestable: Requestable {

    var method: HTTPMethodType { .get }
    var path: String { "/productsTests" } //TODO: handle correct endpoint when exist
}
