//
//  CartProduct.swift
//  iOSAssignment
//
//  Created by David Velarde on 19/12/2021.
//

import Foundation

struct CartProduct: Codable {
    let product: ProductRaw
    var amount: Int
}

extension CartProduct: Equatable {
    static func == (lhs: CartProduct, rhs: CartProduct) -> Bool {
        return lhs.product.id == rhs.product.id && lhs.amount == rhs.amount
    }
}
