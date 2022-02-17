//
//  MemoryCartManager.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 17/02/22.
//

class MemoryCartManager: CartManager {

    var products: [String: CartItem] = [:]

    func addToCart(product: ProductRaw) {
        if products[product.id] != nil {
            products[product.id]?.quantity += 1
        } else {
            products[product.id] = CartItem(product: product, quantity: 1)
        }
    }

    func removeFromCart(product: ProductRaw) {
        if let existingItem = products[product.id],
           existingItem.quantity > 1 {
            products[product.id]?.quantity -= 1
        } else {
            products.removeValue(forKey: product.id)
        }
    }

    func quantity(for product: ProductRaw) -> Int {
        products[product.id]?.quantity ?? 0
    }

    func save() {}

    func load() {}


}
