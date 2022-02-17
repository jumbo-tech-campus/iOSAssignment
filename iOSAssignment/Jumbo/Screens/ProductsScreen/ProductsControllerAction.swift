//
//  ProductsControllerAction.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 16/02/22.
//

enum ProductsControllerAction {
    case firstLoad
    case viewCart
    case addToCart(id: String)
    case removeFromCart(id: String)
}
