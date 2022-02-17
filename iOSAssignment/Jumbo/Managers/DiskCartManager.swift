//
//  DiskCartManager.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 17/02/22.
//

import Foundation

actor DiskCartManager: CartManager {

    private var products: [String: CartItem] = [:]
    private let base: URL

    init() {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        base = documents[0].appendingPathComponent("inCart")
    }

    func addToCart(product: ProductRaw) async {
        if products[product.id] != nil {
            products[product.id]?.quantity += 1
        } else {
            products[product.id] = CartItem(product: product, quantity: 1)
        }
    }

    func removeFromCart(product: ProductRaw) async {
        if let existingItem = products[product.id],
           existingItem.quantity > 1 {
            products[product.id]?.quantity -= 1
        } else {
            products.removeValue(forKey: product.id)
        }
    }

    func quantity(for product: ProductRaw) async -> Int {
        products[product.id]?.quantity ?? 0
    }

    func save() async {

        do {
            let data = try PropertyListEncoder().encode(products)
            try data.write(to: base, options: .atomic)
        } catch {
            print(error) // Need better error handling
        }

    }

    func load() async {
        if let data = try? Data(contentsOf: base),
           let favorites = try? PropertyListDecoder().decode([String: CartItem].self, from: data) { // There are previous data, load it
            self.products = favorites
        } else { // No previous data, start from scratch
            self.products = [:]
        }
    }
}
