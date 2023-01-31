//
//  CartViewModel.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/29/23.
//

import Foundation

class CartControllerViewModel: ProductsViewModel {
    var cartManager: CartManager!
    var data = Observable<[ProductRaw]>(value: [])
    
    func loadData() {
        cartManager.cart.addObserver(fireNow: true) { [weak self] _ in
            if let self = self {
                self.data.value = self.cartManager.getProducts()
            }
        }
    }
}
