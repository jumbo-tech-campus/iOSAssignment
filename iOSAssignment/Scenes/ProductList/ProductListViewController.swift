//
//  ProductListViewController.swift
//  iOSAssignment
//
//  Created by David Velarde on 18/12/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ProductListDisplayLogic: AnyObject {
    func listProducts(viewModel: ProductList.ListProducts.ViewModel)
    func startProductInteraction(viewModel: ProductList.StartProductInteraction.ViewModel)
    func finishProductInteraction(viewModel: ProductList.FinishProductInteraction.ViewModel)
}

class ProductListViewController: UIViewController, ProductListDisplayLogic {
    
    var interactor: ProductListBusinessLogic?
    var router: (NSObjectProtocol & ProductListRoutingLogic & ProductListDataPassing)?
    
    var products = [CartProduct]()
    let productListView = ProductListView(frame: .zero)

    // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
  
  
    private func setup() {
        let viewController = self
        let interactor = ProductListInteractor()
        let presenter = ProductListPresenter()
        let router = ProductListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
  
    // MARK: View lifecycle
    
    override func loadView() {
        self.view = productListView
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
  
    // MARK: Do something
    
    func loadData() {}
    @objc func addProductToCart(index: Int) {}
    @objc func removeProductFromCart(index: Int) {}
    
    func listProducts(viewModel: ProductList.ListProducts.ViewModel) {
        
    }
    
    func startProductInteraction(viewModel: ProductList.StartProductInteraction.ViewModel) {
        
    }
    
    func finishProductInteraction(viewModel: ProductList.FinishProductInteraction.ViewModel) {
        
    }
}
