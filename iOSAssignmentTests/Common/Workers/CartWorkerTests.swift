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
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
    
    class CartDataStoreSpy: CartDataStoreInterface {
        
        var addProductCalled = false
        var getProductsCalled = false
        var removeProductCalled = false
        let products = [CartProduct]()
        
        func getProducts() -> [CartProduct] {
            getProductsCalled = true
            return products
        }
        
        func addProduct(product: ProductRaw) {
            addProductCalled = true
        }
        
        func removeProduct(product: ProductRaw) {
            removeProductCalled = true
        }
    }
  
    func setupProductListWorker() {
        sut = CartWorker()
    }
  
    // MARK: Test doubles
  
    // MARK: Tests
  
    func testAddProductToCart() {
        // Given
        let spy = CartDataStoreSpy()
        sut.dataStore = spy
    
        // When
        let testProduct = Product.create(withId: "123")
        
        sut.addProductToCart(product: testProduct)
        
        // Then
        XCTAssertTrue(spy.addProductCalled, "Add Product on the Data Store should have been called")
    }
    
    func testRemoveProductToCart() {
        // Given
        let spy = CartDataStoreSpy()
        sut.dataStore = spy
    
        // When
        let testProduct = Product.create(withId: "123")
        sut.removeProductFromCart(product: testProduct)
        
        // Then
        XCTAssertTrue(spy.removeProductCalled, "Remove Product on the Data Store should have been called")
    }
}
