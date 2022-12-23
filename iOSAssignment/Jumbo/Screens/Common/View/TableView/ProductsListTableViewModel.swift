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
    case cart(reloadSignal:PublishSubject<Void>)
}

final class ProductsListTableViewModel: BaseTableViewControllerViewModel {
    
    // MARK:- Dependency
    private let repository: ProductsRepositoryType
    
    // MARK:- Properties
    private let products: BehaviorRelay<[ProductRaw]> = BehaviorRelay(value: [])
    private let state: ProductViewState
    public let cellEvents = PublishSubject<ProductListVCActions>.init()
    private let cartManager: CartManagerDiskProtocol
    private let updateCartBadgeSignal: PublishSubject<Int>?
    
    // MARK:- Output
    private var reloadSignal: PublishSubject<Void>?
    
    init(state: ProductViewState = .store
         , cartManager: CartManagerDiskProtocol = DiskCacheCartManager()
         , repository: ProductsRepositoryType = ProductsRepository()
         , updateCartBadgeSignal: PublishSubject<Int>? = nil) {
        self.repository = repository
        self.state = state
        self.cartManager = cartManager
        self.updateCartBadgeSignal = updateCartBadgeSignal
        super.init()
        
        switch state {
        case .cart(let reloadSignal): self.reloadSignal = reloadSignal
        case .store: break
        }
        
        loadData()
        setupObservers()
        configureSectionModels()
    }
}

extension ProductsListTableViewModel {
    func setupObservers() {
        cellEvents.asObservable()
            .subscribe(onNext: { [weak self] events in
                self?.handleEvents(events: events)
            }).disposed(by: disposeBag)
    }
    
    // Adding all the table section items based on the data
    func configureSectionModels() {
        self.sectionsModels = products
            .asObservable()
            .map { (products: [ProductRaw]) -> [TableViewSectionModel] in
                
                var sections = [TableViewSectionModel]()
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
            }.asDriver(onErrorJustReturn: [TableViewSectionModel]())
            .startWith([TableViewSectionModel]())
    }
    
}

extension ProductsListTableViewModel {
    // Load data based on the state
    func loadData() {
        
        // Load all the items stored in the cart
        cartManager.load()
        
        switch state {
        case .cart: getCartItems()
        case .store:  self.products.accept(requestProductList())
        }
    }
    
    // Get data from the repository
    func requestProductList() -> [ProductRaw] {
        repository.fetchRawProducts()?.products ?? []
    }
    
    // Get data from the local cache file
    func getCartItems() {
        let products = cartManager.getCartList().map { $0.product }
        self.products.accept(products)
    }
    
    func getCartItemsCount() -> Int {
        cartManager.getCartList().map { $0.product }.count
    }
    
    // Handle cart operations
    private func addToCart(product: ProductRaw) {
        cartManager.addToCart(product: product)
        cartManager.save()
    }
    
    private func deleteFromCart(product: ProductRaw) {
        cartManager.remoteFromCart(product: product)
        cartManager.save()
    }
    
    // Handle cell events
    
    func handleEvents(events:ProductListVCActions)  {
        switch events {
        case .addToCart(let product): self.addToCart(product: product)
        case .deleteFromCart(let product): self.deleteFromCart(product: product)
        case .reload: self.loadData()
        }
        
        // Reload signal to update store list
        switch self.state {
        case .cart: self.reloadSignal?.onNext(())
        default: break
        }
        
        // Update badge when items are updated in the cart
        let badgeCount = self.getCartItemsCount()
        self.updateCartBadgeSignal?.onNext((badgeCount))
    }
}
