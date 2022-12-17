//
//  ProductsListVCViewControllerViewModel.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//  
//

import UIKit

final class ProductsListVCViewModel: ViewModel {

    // MARK:- Dependency
    
    // MARK:- Properties
    var tableViewVM: ProductsListTableViewModel?

    override init(
        ){
        super.init()
        self.tableViewVM = ProductsListTableViewModel(state: .store)
    }
    
}
