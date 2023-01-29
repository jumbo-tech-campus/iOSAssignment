//
//  ProductViewModel.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/29/23.
//

import Foundation

class ProductCellViewModel {
    static let identifier = "ProductCell"
    static let height = 100.0
    
    var product: ProductRaw!
    var cartManager: CartManager!
    
    var name: String { product.title }
    var description: String? { product.quantity }
    var price: String { "\(product.prices?.price?.amount ?? 0)" }
    var priceDetails: String { "\(product.prices?.unitPrice?.price?.amount ?? 0)/\(product.prices?.unitPrice?.unit ?? "")" }
    var imageUrl: URL? { URL(string: product.imageInfo?.primaryView?.smallestImage?.url ?? "") }
    
    func getProductQuantity() -> Int {
        return cartManager.getProductQuantity(product.id)
    }
    
    func didTapAdd() -> Int {
        cartManager.add(product)
        return cartManager.getProductQuantity(product.id)
    }
    
    func didTapRemove() -> Int {
        cartManager.remove(product)
        return cartManager.getProductQuantity(product.id)
    }
}
