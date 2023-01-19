//
//  CartItem.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/18/23.
//

import Foundation

struct CartItem: Codable {
    let product: ProductRaw
    var quantity: Int = 1
}
