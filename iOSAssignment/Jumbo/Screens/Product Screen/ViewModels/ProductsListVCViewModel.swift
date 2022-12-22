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
    let updateCartBadgeSignal = PublishSubject<Int>.init()
    let viewDidAppearSignal = PublishSubject<Void>.init()
    
    deinit {
        print("Memory deallocated - store")
    }
    
    override init() {
        super.init()
        self.tableViewVM = ProductsListTableViewModel(state: .store
                                                      , updateCartSignal: updateCartSignal
                                                    , updateCartBadgeSignal: updateCartBadgeSignal)
        viewDidAppearSignal.asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return  }
                let badgeCount = self.tableViewVM?.getCartItemsCount() ?? 0
                self.updateCartBadgeSignal.onNext(badgeCount)
            }).disposed(by: disposeBag)
    }
    
    func presentCartView() {
        let cartVM = CartListVCViewModel(updateCartSignal: updateCartSignal)
        presentCartSignal.onNext(cartVM)
    }
    
    
}
