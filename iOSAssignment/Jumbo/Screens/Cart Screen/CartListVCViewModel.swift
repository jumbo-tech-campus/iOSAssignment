//
//  CartListVCViewControllerViewModel.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 20/12/2022.
//  
//

import UIKit

final class CartListVCViewModel: ViewModel {

    // MARK:- Dependency
    private let imageManager: ImageManager
    private let cartManager: CartManager
    
    // MARK:- Properties
    var products: [ProductTableViewCellViewModel] = []
    

    init(products: [ProductTableViewCellViewModel]
         , imageManager: ImageManager = ImageManager()
         , cartManager : CartManager = CartManager()) {
             
             self.products = products
             self.imageManager = imageManager
             self.cartManager = cartManager
        super.init()
    }
    
}
