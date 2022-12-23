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
    case addToCart(product: ProductRaw)
    case deleteFromCart(product: ProductRaw)
    case reload
}

class ProductsListVCViewModel: ViewModel {

    // MARK:- Dependency
    
    // MARK:- Properties
    var tableViewVM: ProductsListTableViewModel?
    let presentCartSignal = PublishSubject<CartListVCViewModel>()
    let updateCartBadgeSignal = PublishSubject<Int>.init()
    let viewDidAppearSignal = PublishSubject<Void>.init()
    
    init(state: ProductViewState) {
        super.init()
        self.tableViewVM = ProductsListTableViewModel(state: state
                                                    , updateCartBadgeSignal: updateCartBadgeSignal)
        
        // Trigger event to update badge on view appear
        viewDidAppearSignal.asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return  }
                let badgeCount = self.tableViewVM?.getCartItemsCount() ?? 0
                self.updateCartBadgeSignal.onNext(badgeCount)
            }).disposed(by: disposeBag)
    }
    
    public func reloadData() {
        tableViewVM?.cellEvents.onNext(.reload)
    }
}
