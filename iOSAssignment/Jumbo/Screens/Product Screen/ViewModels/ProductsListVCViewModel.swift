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
    case reload
}

final class ProductsListVCViewModel: ViewModel {

    // MARK:- Dependency
    
    // MARK:- Properties
    var tableViewVM: ProductsListTableViewModel?
    let updateCartSignal = BehaviorRelay<Void>.init(value: ())
    let presentCartSignal = PublishSubject<CartListVCViewModel>()

    deinit {
        print("Memory deallocated - store")
    }
    
    override init() {
        super.init()
        self.tableViewVM = ProductsListTableViewModel(state: .store, updateCartSignal: updateCartSignal)
    }
    
    func presentCartView() {
        let cartVM = CartListVCViewModel(updateCartSignal: updateCartSignal)
        presentCartSignal.onNext(cartVM)
    }
}
