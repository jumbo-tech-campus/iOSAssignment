//
//  CartManager.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 30/10/21.
//

import Foundation

protocol CartManagerProtocol {
    func addProduct(_ product: Product)
    func removeProduct(_ product: Product)
    func loadProducts() -> [CartProduct]
    func countProducts(id: String) -> Int
}

final class CartManager: CartManagerProtocol {

    // MARK: - Attributes

    private let database: DatabaseProtocol

    // MARK: - Life cycle

    init(database: DatabaseProtocol = DatabaseManager()) {
        self.database = database
    }

    // MARK: - Custom methods

    private func getCart() -> Cart? {
        do {
            return try database.loadObject(type: Cart.self)
        } catch {
            return nil
        }
    }

    func addProduct(_ product: Product) {
        do {
            if let cart = getCart() {
                cart.addProduct(product)
                try database.save(model: cart)
            } else {
                try database.save(model: Cart(product: product))
            }
        } catch {
            //TODO: handle error
        }
    }

    func removeProduct(_ product: Product) {
        do {
            if let cart = getCart() {
                cart.removeProduct(product)
                try database.save(model: cart)
            }
        } catch {
            //TODO: handle error
        }
    }

    func loadProducts() -> [CartProduct] {
        getCart()?.products ?? []
    }

    func countProducts(id: String) -> Int {
        guard let cart = getCart() else { return 0 }
        return cart.countProducts(id: id)
    }
}
