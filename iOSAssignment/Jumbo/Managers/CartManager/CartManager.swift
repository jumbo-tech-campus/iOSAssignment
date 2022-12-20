//
//  CartManager.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 20/12/2022.
//

import Foundation

class CartManager: CartManagerProtocol {
    
    var products: [String: CartDetails] = [:]
     
    func addToCart(product: ProductRaw) {
        if products[product.id] != nil {
            products[product.id]?.quantity += 1
        } else {
            products[product.id] = CartDetails(product: product, quantity: 1)
        }
    }
    
    func remoteFromCart(product: ProductRaw) {
        if let existingProduct = products[product.id],
           existingProduct.quantity > 1 {
            products[product.id]?.quantity -= 1
        } else {
            products.removeValue(forKey: product.id)
        }
    }
    
    func quantity(for product: ProductRaw) -> Int {
        products[product.id]?.quantity ?? 0
    }
}
