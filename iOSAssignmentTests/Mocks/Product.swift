//
//  Product.swift
//  iOSAssignmentTests
//
//  Created by David Velarde on 19/12/2021.
//

import Foundation

@testable import iOSAssignment

enum Product {
    static func create(withId id: String) -> ProductRaw {
        return ProductRaw(id: id, title: "abc", prices: nil, available: true, productType: nil, imageInfo: nil, topLevelCategory: nil, topLevelCategoryId: nil, quantity: nil)
    }
}
