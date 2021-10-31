//
//  CartProduct.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 30/10/21.
//

import Foundation

final class CartProduct: Codable {

    // MARK: - Attributes

    private(set) var count: Int = 0
    private(set) var product: Product?

    // MARK: - Life cycle

    init(product: Product) {
        addProduct(product: product)
    }

    // MARK: - Custom methods

    func addProduct(product: Product) {
        self.product = product
        count += 1
    }

    func removeProduct() {
        if count == 0 { return }
        if count == 1 { product = nil }
        count -= 1
    }

    func calcSubTotal() -> Int {
        (product?.prices?.price?.amount ?? 0) * count
    }
}
