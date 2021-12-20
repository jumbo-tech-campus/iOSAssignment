//
//  CartWorkerTests.swift
//  iOSAssignmentTests
//
//  Created by David Velarde on 18/12/2021.
//

import Foundation

@testable import iOSAssignment
import XCTest

class CartWorkerTests: XCTestCase {
  
    // MARK: Subject under test
    
    var sut: CartWorker!
    
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupProductListWorker()
        UserDefaults.standard.removeObject(forKey: "cart")
    }
  
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: "cart")
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupProductListWorker() {
        sut = CartWorker()
    }
  
    // MARK: Test doubles
  
    // MARK: Tests
  
    func testAddProductToCart() {
        // Given
        let spy = CartDataStore()
        sut.dataStore = spy
    
        // When
        let testProduct = Product.create(withId: "123")
        
        sut.addProductToCart(product: testProduct)
        
        // Then
        XCTAssertEqual(spy.cartProducts.count, 1, "The amount of products in the cart after calling addProductToCart should be 1")
    }
    
    func testRemoveProductToCart() {
        // Given
        let spy = CartDataStore()
        sut.dataStore = spy
    
        // When
        let testProduct = Product.create(withId: "123")
        sut.addProductToCart(product: testProduct)
        sut.addProductToCart(product: testProduct)
        sut.removeProductFromCart(product: testProduct)
        
        // Then
        XCTAssertEqual(spy.cartProducts.count, 1, "The amount of products in the cart after calling removeProductFromCart should be 1")
    }
}
