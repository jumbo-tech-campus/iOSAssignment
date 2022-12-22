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

final class CartListVCViewModel: ProductsListVCViewModel {

    // MARK:- Dependency
    
    deinit {
        print("Memory deallocated - cart")
    }

    init(reloadSignal: PublishSubject<Void>) {
        super.init(state: .cart(reloadSignal: reloadSignal))
    }
}
