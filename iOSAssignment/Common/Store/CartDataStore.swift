//
//  CartDataStore.swift
//  iOSAssignment
//
//  Created by David Velarde on 19/12/2021.
//

import Foundation

protocol CartDataStoreInterface {
    func getProducts() -> [CartProduct]
    func addProduct(product: ProductRaw)
    func removeProduct(product: ProductRaw)
}

// Working with ProductRaw instead of ids because
// products may dissapear from the app at some point in the future
// and we should be able to have at least some metadata
// to show to the user
struct CartDataStore: CartDataStoreInterface {
    
    func getProducts() -> [CartProduct] {
        return [CartProduct]()
    }
    
    func addProduct(product: ProductRaw) {
        
    }
    
    func removeProduct(product: ProductRaw) {
        
    }
}
