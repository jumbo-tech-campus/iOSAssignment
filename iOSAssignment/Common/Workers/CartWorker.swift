//
//  CartWorker.swift
//  iOSAssignment
//
//  Created by David Velarde on 18/12/2021.
//

import Foundation

protocol CartWorkerInterface {
    var cartProducts: [CartProduct] { get }
    func addProductToCart(product: ProductRaw)
    func removeProductFromCart(product: ProductRaw)
}

class CartWorker: CartWorkerInterface {
    
    var dataStore: CartDataStoreInterface = CartDataStore()
    
    var cartProducts: [CartProduct] {
        get {
            return dataStore.cartProducts
        }
        set {
            dataStore.cartProducts = newValue
        }
    }
    
    func addProductToCart(product: ProductRaw) {
        if let foundIndex = cartProducts.firstIndex(where: { $0.product.id == product.id }) {
            let newAmount = cartProducts[foundIndex].amount + 1
            cartProducts[foundIndex] = CartProduct(product: product, amount: newAmount)
        } else {
            cartProducts.append(CartProduct(product: product, amount: 1))
        }
    }
    
    func removeProductFromCart(product: ProductRaw) {
        if let foundIndex = cartProducts.firstIndex(where: { $0.product.id == product.id }) {
            let newAmount = cartProducts[foundIndex].amount - 1
            if newAmount <= 0 {
                cartProducts.remove(at: foundIndex)
            } else {
                cartProducts[foundIndex] = CartProduct(product: product, amount: newAmount)
            }
        }
    }
}
