//
//  CartManager.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 17/02/22.
//

protocol CartManager {
    func addToCart(product: ProductRaw)
    func removeFromCart(product: ProductRaw)
    func quantity(for: ProductRaw) -> Int
    func save()
    func load() -> [CartItem]
}
