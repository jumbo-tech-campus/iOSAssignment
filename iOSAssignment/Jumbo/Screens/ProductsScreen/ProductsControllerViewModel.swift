//
//  ProductsViewModel.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/29/23.
//

import Foundation

protocol ProductsViewModel {
    var data: Observable<[ProductRaw]> {get set}
    func loadData()
    
    var cartManager: CartManager! {get set}
}

class ProductsControllerViewModel: ProductsViewModel {
    var cartManager: CartManager!
    var data = Observable<[ProductRaw]>(value: [])
    
    func loadData() {
        let productRepository = ProductsRepository()
        let products = productRepository.fetchRawProducts()?.products ?? []
        cartManager.cart.addObserver(fireNow: true) { [weak self] _ in
            self?.data.value = products
        }
    }
}
