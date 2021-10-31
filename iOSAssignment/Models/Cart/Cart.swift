//
//  Cart.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 30/10/21.
//

import Foundation

protocol CartProtocol {
    func addProduct(_ product: Product)
    func removeProduct(_ product: Product)
    func calcSubTotal() -> Int
    func countProducts(id: String) -> Int
}

final class Cart: ObjectRepresentable, CartProtocol {

    // MARK: - Attributes

    static var key: String { "cart" }
    private(set) var products = [CartProduct]()

    // MARK: - Life cycle

    init(product: Product) {
        products = [CartProduct(product: product)]
    }

    // MARK: - Custom methods

    private func contains(_ product: Product) -> Int? {
        products.firstIndex(where: { $0.product?.id == product.id })
    }

    func addProduct(_ product: Product) {
        if let position = contains(product),
           let item = products[safe: position] {
            item.addProduct(product: product)
        } else {
            products.append(CartProduct(product: product))
        }
    }

    func removeProduct(_ product: Product) {
        if let position = contains(product),
           let item = products[safe: position] {
            if item.count == 1 {
                products.remove(at: position)
            } else {
                item.removeProduct()
            }
        }
    }

    func calcSubTotal() -> Int {
        products
            .map { $0.calcSubTotal() }
            .reduce(0) { $0 + $1 }
    }

    func countProducts(id: String) -> Int {
        products.filter { $0.product?.id == id }.first?.count ?? 0
    }
}
