//
//  CartController.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/18/23.
//

import UIKit

class CartController: ProductsController {
    override func viewDidLoad() {
        self.viewModel = CartControllerViewModel()
        super.viewDidLoad()
    }
}
