//
//  CartManagerTests.swift
//  iOSAssignmentTests
//
//  Created by Ramkrishna Baddi on 23/12/2022.
//

@testable import iOSAssignment
import XCTest


final class CartManagerTests: XCTestCase {
    
    var cartManager: CartManager!
    var products: [ProductRaw] = []

    override func setUpWithError() throws {
        products = try XCTUnwrap(ProductsRepository().fetchRawProducts()?.products.map { $0 } )
        cartManager = CartManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        products = []
        cartManager = nil
    }

    func testAddProductsIntoTheCart() throws {
        let first = try XCTUnwrap(products.first)
        let expectedQuantity: Int = 3
        
        (1...3).forEach({_ in cartManager.addToCart(product: first) })
        
        let actualQuantity = cartManager.quantity(for: first)
        
        XCTAssertEqual(expectedQuantity, actualQuantity)
    }
    
    func testRemoveProductsFromTheCart() throws {
        let first = try XCTUnwrap(products.first)
        let expectedQuantity: Int = 0
        
        cartManager.addToCart(product: first)
        cartManager.remoteFromCart(product: first)
        
        let actualQuantity = cartManager.quantity(for: first)
        
        XCTAssertEqual(expectedQuantity, actualQuantity)
    }
    
    func testCartItems() throws {
        let first = try XCTUnwrap(products.first)
        let second = try XCTUnwrap(products.prefix(2).last)
        let expectedListCount: Int = 2
        
        cartManager.addToCart(product: first)
        cartManager.addToCart(product: second)
        
        let actualListCount = cartManager.getCartList().count
        
        XCTAssertEqual(expectedListCount, actualListCount)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
