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
    
    // MARK:- Properties
    var tableViewVM: ProductsListTableViewModel?
    

    override init() {
        super.init()
        self.tableViewVM = ProductsListTableViewModel(state: .cart)
    }
}
