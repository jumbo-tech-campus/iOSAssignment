//
//  ProductsControllerAction.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 16/02/22.
//

enum ProductsControllerAction {
    case reload
    case viewCart
    case addToCart(product: ProductRaw)
    case removeFromCart(product: ProductRaw)
    case cartDismissed
}
