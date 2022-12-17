//
//  ProductTableViewCellViewModel.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//  
//

import Foundation
import RxSwift

class ProductTableViewCellViewModel: BaseTableViewCellViewModel {
    
    // MARK:- Dependency
    
    //MARK:- Input
    private let product: ProductRaw

    // MARK- Output
    
    let cellButtonDidTap: PublishSubject<Void> = PublishSubject<()>()
    
    init(product: ProductRaw){
        self.product = product
        super.init()
    }
}
