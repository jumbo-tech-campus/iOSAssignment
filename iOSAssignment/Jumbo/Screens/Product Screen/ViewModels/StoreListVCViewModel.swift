//
//  StoreListVCViewModel.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 22/12/2022.
//

import Foundation
import RxSwift
import RxCocoa

final class StoreListVCViewModel: ProductsListVCViewModel {
    
    // MARK:- Properties
    let reloadSignal = PublishSubject<Void>()
    
    init() {
        super.init(state: .store)
        
        reloadSignal.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.reloadData()
            }).disposed(by: disposeBag)
    }
    
    public func presentCartView() {
        let cartVM = CartListVCViewModel(reloadSignal: reloadSignal)
        presentCartSignal.onNext(cartVM)
    }
}
