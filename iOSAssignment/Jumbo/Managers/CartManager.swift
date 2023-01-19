//
//  CartManager.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/18/23.
//

import Foundation

protocol CartManagerDelegate {
    func didUpdateCart()
}

class CartManager {
    
    static let shared = CartManager()
    var delegate: CartManagerDelegate?
    
    var cart: [String: CartItem] = [:]
    
    func add(_ product: ProductRaw) {
        if var cartItem = cart[product.id] {
            cartItem.quantity += 1
            cart[product.id] = cartItem
        } else {
            cart[product.id] = CartItem(product: product)
            delegate?.didUpdateCart()
        }
    }
    
    func remove(_ product: ProductRaw) {
        if var cartItem = cart[product.id] {
            cartItem.quantity -= 1
            if cartItem.quantity == 0 {
                cart.removeValue(forKey: product.id)
                delegate?.didUpdateCart()
            } else {
                cart[product.id] = cartItem
            }
        }
    }
    
    func save() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(cart)
            UserDefaults.standard.set(data, forKey: "cart")

        } catch {
            print("Unable to Encode Cart (\(error))")
        }
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: "cart") {
            do {
                let decoder = JSONDecoder()
                cart = try decoder.decode([String: CartItem].self, from: data)
            } catch {
                print("Unable to Decode Cart (\(error))")
            }
        }
    }
}
