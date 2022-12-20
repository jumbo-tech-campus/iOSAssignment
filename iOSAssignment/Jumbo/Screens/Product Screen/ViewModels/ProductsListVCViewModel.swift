//
//  ProductsListVCViewControllerViewModel.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//  
//

import UIKit
import RxSwift
import RxCocoa

enum ProductListVCActions {
    case viewCart
    case addToCart(product: ProductRaw)
    case deleteFromCart(product: ProductRaw)
}

final class ProductsListVCViewModel: ViewModel {

    // MARK:- Dependency
    
    // MARK:- Properties
    var tableViewVM: ProductsListTableViewModel?
    var cartViewModel: PublishSubject<CartListVCViewModel>

    init( cartViewModel: PublishSubject<CartListVCViewModel> = PublishSubject<CartListVCViewModel>.init()) {
        self.cartViewModel = cartViewModel
        super.init()
        self.tableViewVM = ProductsListTableViewModel(state: .store)
    }
}
