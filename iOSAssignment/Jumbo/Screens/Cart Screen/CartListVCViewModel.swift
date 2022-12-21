//
//  CartListVCViewControllerViewModel.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 20/12/2022.
//  
//

import UIKit
import RxSwift
import RxCocoa

final class CartListVCViewModel: ViewModel {

    // MARK:- Dependency
    
    // MARK:- Properties
    var tableViewVM: ProductsListTableViewModel?
    
    deinit {
        print("Memory deallocated - cart")
    }

    init(updateCartSignal: BehaviorRelay<Void>) {
        super.init()
        self.tableViewVM = ProductsListTableViewModel(state: .cart, updateCartSignal: updateCartSignal)
    }
}
