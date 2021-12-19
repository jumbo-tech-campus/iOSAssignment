//
//  CartDataStore.swift
//  iOSAssignment
//
//  Created by David Velarde on 19/12/2021.
//

import Foundation

protocol CartDataStoreInterface {
    var cartProducts: [CartProduct] { get set }
}

// Working with ProductRaw instead of ids because
// products may dissapear from the app at some point in the future
// and we should be able to have at least some metadata
// to show to the user
class CartDataStore: CartDataStoreInterface {
    
    var cartProducts: [CartProduct] {
        didSet {
            saveCart()
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "cart"), let decoded = try? JSONDecoder().decode([CartProduct].self, from: data) {
            cartProducts = decoded
        } else {
            cartProducts = [CartProduct]()
        }
    }
    
    func saveCart() {
        guard let data = try? JSONEncoder().encode(cartProducts) else {
            return
        }
        
        UserDefaults.standard.set(data, forKey: "cart")
    }
}
