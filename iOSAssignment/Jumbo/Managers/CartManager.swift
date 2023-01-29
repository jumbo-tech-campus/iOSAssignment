//
//  CartManager.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/18/23.
//

import Foundation

protocol LocalCacheable {
    func save()
    func load()
}

class CartManager {
    
    var cart = Observable<[String: CartItem]>(value: [:])
    
    func add(_ product: ProductRaw) {
        if var cartItem = cart.value[product.id] {
            cartItem.quantity += 1
            cart.value[product.id] = cartItem
        } else {
            cart.value[product.id] = CartItem(product: product)
        }
        save()
    }
    
    func remove(_ product: ProductRaw) {
        if var cartItem = cart.value[product.id] {
            cartItem.quantity -= 1
            if cartItem.quantity == 0 {
                cart.value.removeValue(forKey: product.id)
            } else {
                cart.value[product.id] = cartItem
            }
        }
        save()
    }
    
    func getProducts() -> [ProductRaw] {
        return cart.value.map({$1.product})
    }
    
    func getProductQuantity(_ productId: String) -> Int {
        return cart.value[productId]?.quantity ?? 0
    }
}

extension CartManager: LocalCacheable {
    func save() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(cart.value)
            UserDefaults.standard.set(data, forKey: "cart")

        } catch {
            print("Unable to Encode Cart (\(error))")
        }
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: "cart") {
            do {
                let decoder = JSONDecoder()
                cart.value = try decoder.decode([String: CartItem].self, from: data)
            } catch {
                print("Unable to Decode Cart (\(error))")
            }
        }
    }
}
