//
//
//  BaseTableViewCellViewModel.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//

import Foundation
import RxSwift
import RxCocoa

class BaseTableViewCellViewModel: ViewModel {
    
    let cellHeight: CGFloat
    let cellDidSelectSignal = PublishSubject<Void>()
    
    init(cellHeight: CGFloat = UITableView.automaticDimension) {
        self.cellHeight = cellHeight
        super.init()
        self.cellDidSelectSignal
            .asObservable()
            .throttle(.milliseconds(200), latest: false, scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                self?.cellDidSelectSignal.onNext(())
            }).disposed(by: disposeBag)
    }
    
    func cellDidSelect() {
        // Override this
    }
    
}
