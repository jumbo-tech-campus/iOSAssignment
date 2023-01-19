//
//  CartManager.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/18/23.
//

import Foundation

class CartManager {
    
    static let shared = CartManager()
    
    var cart: [String: CartItem] = [:]
    
    func add(_ product: ProductRaw) {
        var cartItemToAdd: CartItem!
        if var cartItem = cart[product.id] {
            cartItem.quantity += 1
            cartItemToAdd = cartItem
        } else {
            cartItemToAdd = CartItem(product: product)
        }
        cart[product.id] = cartItemToAdd
    }
    
    func remove(_ product: ProductRaw) {
        if var cartItem = cart[product.id] {
            cartItem.quantity -= 1
            if cartItem.quantity == 0 {
                cart.removeValue(forKey: product.id)
            } else {
                cart[product.id] = cartItem
            }
        }
    }
}
