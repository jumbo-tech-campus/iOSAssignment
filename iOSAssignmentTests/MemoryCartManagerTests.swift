//
//  MemoryCartManagerTests.swift
//  iOSAssignmentTests
//
//  Created by Rodrigo Ruiz Murguia on 17/02/22.
//

@testable import iOSAssignment
import XCTest

class MemoryCartManagerTests: XCTestCase {

    var cartManager: MemoryCartManager!
    var products: [ProductRaw]!

    override func setUpWithError() throws {
        try super.setUpWithError()

        products = try XCTUnwrap(ProductsRepository().fetchRawProducts()?.products).prefix(3).map { $0 } 
        cartManager = MemoryCartManager()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        cartManager = nil
        products = nil
    }

    func testAddMultipleTimesTheSameProduct() throws {

        let first = try XCTUnwrap(products.first)
        let expectedCount = 5

        (1...5).forEach { _ in cartManager.addToCart(product: first) }

        let actualCount = cartManager.quantity(for: first)

        XCTAssertEqual(expectedCount, actualCount)
    }

    func testAddAndRemoveProduct() throws {

        let first = try XCTUnwrap(products.first)
        let expectedCount = 0

        cartManager.addToCart(product: first)
        cartManager.removeFromCart(product: first)

        let actualCount = cartManager.quantity(for: first)

        XCTAssertEqual(expectedCount, actualCount)
    }

    func testAddAndRemoveMultipleProducts() throws {

        products.forEach(cartManager.addToCart(product:))
        products.forEach(cartManager.addToCart(product:)) // Add two times all items

        let first = try XCTUnwrap(products.first)
        cartManager.addToCart(product: first) // Add first item another time

        let last = try XCTUnwrap(products.last)
        cartManager.removeFromCart(product: last) // Remove last one once

        let expectedCount = [3, 2, 1]
        let actualCount = products.map(cartManager.quantity(for: ))

        XCTAssertEqual(expectedCount, actualCount)
    }

}
