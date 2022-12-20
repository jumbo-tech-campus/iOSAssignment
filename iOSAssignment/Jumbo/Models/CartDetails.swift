//
//  CartDetails.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 20/12/2022.
//

import Foundation

struct CartDetails: Codable {
    let product: ProductRaw
    var quantity: Int
}
