//
//  ProductsListTableView.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//  
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class ProductsListTableView: TableView {
    
    var viewModel: ProductsListTableViewModel! {
        didSet {
            bind()
            // set delegate if need
            delegate = viewModel
        }
    }
    
    override func updateConstraints() {
        setup()
        super.updateConstraints()
    }
    
    func setup(){
        let cells = [
            ProductTableViewCell.self,
            LineSeparatorTableViewCell.self
        ]
        registerCells(cells: cells)
        
        rowHeight =  UITableView.automaticDimension
        keyboardDismissMode = .onDrag
        tableFooterView = UIView()
        separatorStyle = .none
    }
}

extension ProductsListTableView: HasViewModel {
    func bind() {
        viewModel
            .sectionsModels
            .asDriver()
            .drive(self.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
    }
}

