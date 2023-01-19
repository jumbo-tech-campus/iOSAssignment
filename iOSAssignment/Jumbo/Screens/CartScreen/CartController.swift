//
//  CartController.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/18/23.
//

import UIKit

class CartController: ProductsController {
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        products = CartManager.shared.cart.map({$1.product})
        tableView.reloadData()
    }
    
    override func didTapRemoveProduct(_ product: ProductRaw) -> Int {
        let quantity = super.didTapRemoveProduct(product)
        if quantity == 0 {
            loadData()
        }
        return quantity
    }
}
