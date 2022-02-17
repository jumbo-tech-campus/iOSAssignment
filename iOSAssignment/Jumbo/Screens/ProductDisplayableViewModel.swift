//
//  ProductDisplayableViewModel.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 17/02/22.
//

import Combine

protocol ProductDisplayableViewModel: AnyObject {
    @MainActor var productsPublisher: Published<[ProductCellViewModel]>.Publisher { get }
    @MainActor func productsEvent(action: ProductsControllerAction)
}
