//
//  BaseTableViewCell.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//

import Foundation

class BaseTableViewCell<T: BaseTableViewCellViewModel>: TableViewCell {
    
    var viewModel: T! {
        didSet {
            bind()
        }
    }
    
    open func bind() {
        
    }
    
}

extension BaseTableViewCell: ViewModelAssignable {
    
    func assignViewModel(viewModel: Any) {
        assert(viewModel is T, "\(viewModel.self) is not type of \(T.self)")
        if let v = viewModel as? T {
            self.viewModel = v
        }
    }
    
}

protocol ViewModelAssignable {
    func assignViewModel(viewModel: Any)
}
