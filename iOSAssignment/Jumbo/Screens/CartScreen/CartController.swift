//
//  CartController.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/18/23.
//

import UIKit

class CartController: ProductsController {
    
    override func loadData() {
        products = CartManager.shared.cart.map({$1.product})
        tableView.reloadData()
    }
    
}
