//
//  CartManager.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 17/02/22.
//

protocol CartManager {
    func addToCart(product: ProductRaw) async
    func removeFromCart(product: ProductRaw) async
    func quantity(for: ProductRaw) async -> Int
    func save() async
    func load() async
}
