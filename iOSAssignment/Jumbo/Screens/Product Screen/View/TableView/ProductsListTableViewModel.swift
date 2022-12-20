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
    private let cellEvents = PublishSubject<ProductListVCActions>.init()
    private let cartManager: CartManagerDiskProtocol
    
    // MARK:- Output
    let updateCartSignal: BehaviorRelay<Void>
    
    init(state: ProductViewState = .store
        , cartManager: CartManagerDiskProtocol = DiskCacheCartManager()
        , repository: ProductsRepositoryType = ProductsRepository()
        , updateCartSignal: BehaviorRelay<Void>) {
        self.repository = repository
        self.state = state
        self.cartManager = cartManager
        self.updateCartSignal = updateCartSignal
        super.init()
        
        cartManager.load()
        loadData()
        setupObservers()
        configureSectionModels()
    }
    
    private func addToCart(product: ProductRaw) {
        cartManager.addToCart(product: product)
        cartManager.save()
    }
    
    private func deleteFromCart(product: ProductRaw) {
        cartManager.remoteFromCart(product: product)
        cartManager.save()
    }
}

extension ProductsListTableViewModel {
    func setupObservers() {
        cellEvents.asObservable()
            .subscribe(onNext: { [weak self] events in
                guard let self = self else { return }
                switch events {
                    case .addToCart(let product): self.addToCart(product: product)
                    case .deleteFromCart(let product): self.deleteFromCart(product: product)
                    default : break
                }
                
                switch self.state {
                    case .cart: self.updateCartSignal.accept(())
                    default: break
                }
            }).disposed(by: disposeBag)
    }
    
    func configureSectionModels() {
        self.sectionsModels = Observable.combineLatest(products, updateCartSignal, resultSelector: {  products, updateCartSignal -> [TableViewSectionModel] in
         
                var sections = [TableViewSectionModel]()
                self.cartManager.load()
                var productItems = [TableViewSectionItem]()
                for product in products {
                    let item = TableViewSectionItem(reusableIdentifier: ProductTableViewCell.reuseIdentifier, viewModel: ProductTableViewCellViewModel(product: product, cartQuantity: self.cartManager.quantity(for: product)
                                                                      , events: self.cellEvents))
                    let seperatorItem = TableViewSectionItem(reusableIdentifier: LineSeparatorTableViewCell.subjectLabel, viewModel: LineSeparatorTableViewCellViewModel(lineSeparatorType: .default))
                    productItems.append(item)
                    productItems.append(seperatorItem)
                }
                
                let productSection = TableViewSectionModel(items: productItems)
                sections.append(productSection)
                return sections
        }).asDriver(onErrorJustReturn: [])
    }
    
    func loadData() {
        switch state {
        case .cart: getCartItems()
        case .store:  requestProductList()
        }
    }
    
    // Get data from the repository
    func requestProductList() {
        let products = repository.fetchRawProducts()?.products ?? []
        self.products.accept(products)
    }
    
    func getCartItems() {
        let products = cartManager.getCartList().map { $0.product }
        self.products.accept(products)
    }
  
}
