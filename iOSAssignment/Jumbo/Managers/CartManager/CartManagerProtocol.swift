//
//  CartManagerProtocol.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 20/12/2022.
//

import Foundation

protocol CartManagerProtocol {
    func addToCart(product: ProductRaw)
    func remoteFromCart(product: ProductRaw)
    func quantity(for product: ProductRaw) -> Int
}

protocol CartManagerDiskProtocol: CartManagerProtocol {
    func save()
    func load()
}
