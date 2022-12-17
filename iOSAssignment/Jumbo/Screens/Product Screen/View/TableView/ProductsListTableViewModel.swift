//
//  ProductsListTableViewModel.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//  
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

enum ProductViewState {
    case store
    case cart
}

final class ProductsListTableViewModel: BaseTableViewControllerViewModel {

    // MARK:- Dependency
    private let repository: ProductsRepositoryType

    // MARK:- Properties
    private let products: BehaviorRelay<[ProductRaw]> = BehaviorRelay(value: [])
    private let state: ProductViewState
    // MARK:- Output

    
    init(state: ProductViewState = .store,
         repository: ProductsRepositoryType = ProductsRepository()) {
        self.repository = repository
        self.state = state
        super.init()
        
        setupObservers()
        configureSectionModels()
        requestProductList()
    }
}

extension ProductsListTableViewModel {
    func setupObservers() {
        switch state {
        case .cart: break
        case .store: break
        }
    }
    
    func configureSectionModels() {
        self.sectionsModels = products
            .asObservable()
            .map { [weak self] (products: [ProductRaw]) -> [TableViewSectionModel] in
                
                var sections = [TableViewSectionModel]()
                guard let self = self else { return sections }
                
                    var productItems = [TableViewSectionItem]()
                    for product in products {
                        let item = TableViewSectionItem(reusableIdentifier: ProductTableViewCell.reuseIdentifier, viewModel: ProductTableViewCellViewModel(product: product))
                            let seperatorItem = TableViewSectionItem(reusableIdentifier: LineSeparatorTableViewCell.subjectLabel, viewModel: LineSeparatorTableViewCellViewModel(lineSeparatorType: .default))
                        productItems.append(item)
                        productItems.append(seperatorItem)
                    }

                    let productSection = TableViewSectionModel(items: productItems)
                    sections.append(productSection)
                return sections
        }
        .asDriver(onErrorJustReturn: [TableViewSectionModel]())
        .startWith([TableViewSectionModel]())
                        
    }
    
    func requestProductList() {
        let products = repository.fetchRawProducts()?.products ?? []
        self.products.accept(products)
    }
}

