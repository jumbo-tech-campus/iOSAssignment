//
//  CartWorker.swift
//  iOSAssignment
//
//  Created by David Velarde on 18/12/2021.
//

import Foundation

protocol CartWorkerInterface {
    func addProductToCart(product: ProductRaw)
    func removeProductFromCart(product: ProductRaw)
}

struct CartWorker: CartWorkerInterface {
    
    var dataStore: CartDataStoreInterface = CartDataStore()
    
    func addProductToCart(product: ProductRaw) {
        
    }
    
    func removeProductFromCart(product: ProductRaw) {
        
    }
    
    
}
