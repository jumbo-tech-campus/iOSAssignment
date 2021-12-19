//
//  ProductListPresenter.swift
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

protocol ProductListPresentationLogic {
    func listProducts(response: ProductList.ListProducts.Response)
    func startProductInteraction(response: ProductList.StartProductInteraction.Response)
    func finishProductInteraction(response: ProductList.FinishProductInteraction.Response)
}

class ProductListPresenter: ProductListPresentationLogic {
    
    weak var viewController: ProductListDisplayLogic?
  
    // MARK: Implementation
    func listProducts(response: ProductList.ListProducts.Response) {
        
    }
    
    func startProductInteraction(response: ProductList.StartProductInteraction.Response) {
        
    }
    
    func finishProductInteraction(response: ProductList.FinishProductInteraction.Response) {
        
    }
}
