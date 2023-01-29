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
    
    var quantity: Observable<Int> { Observable<Int>(value: cartManager.getProductQuantity(product.id)) }
    
    func didTapAdd() {
        cartManager.add(product)
        quantity.value = cartManager.getProductQuantity(product.id)
    }
    
    func didTapRemove() {
        cartManager.remove(product)
        quantity.value = cartManager.getProductQuantity(product.id)
    }
}
