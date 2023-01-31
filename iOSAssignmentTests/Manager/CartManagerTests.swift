//
//  CartManagerTests.swift
//  iOSAssignmentTests
//
//  Created by Spam C. on 1/29/23.
//

@testable import iOSAssignment
import XCTest

final class CartManagerTests: XCTestCase {
    
    var cartManager: CartManager!
    var products: [ProductRaw]!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cartManager = CartManager()
        let productRepository = ProductsRepository()
        products = productRepository.fetchRawProducts()?.products
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cartManager = nil
        products = nil
    }
    
    func testAddProduct() throws {
        let product = try XCTUnwrap(products.first)
        let expectedQuantity = 1
        cartManager.add(product)
        let quantity = cartManager.getProductQuantity(product.id)
        XCTAssertEqual(expectedQuantity, quantity)
    }
    
    func testAddMultipleProducts() throws {
        let firstProduct = try XCTUnwrap(products[0])
        let secondProduct = try XCTUnwrap(products[1])
        let thirdProduct = try XCTUnwrap(products[2])
        let expectedFirstQuantity = 3
        let expectedSecondQuantity = 4
        let expectedThirdQuantity = 5
        
        (1...expectedFirstQuantity).forEach({_ in cartManager.add(firstProduct) })
        (1...expectedSecondQuantity).forEach({_ in cartManager.add(secondProduct) })
        (1...expectedThirdQuantity).forEach({_ in cartManager.add(thirdProduct) })
        
        let firstQuantity = cartManager.getProductQuantity(firstProduct.id)
        let secondQuantity = cartManager.getProductQuantity(secondProduct.id)
        let thirdQuantity = cartManager.getProductQuantity(thirdProduct.id)
        
        XCTAssertEqual(expectedFirstQuantity, firstQuantity)
        XCTAssertEqual(expectedSecondQuantity, secondQuantity)
        XCTAssertEqual(expectedThirdQuantity, thirdQuantity)
    }
    
    func testRemoveProduct() throws {
        let product = try XCTUnwrap(products.first)
        let expectedQuantity = 0
        
        cartManager.add(product)
        cartManager.remove(product)
        
        let quantity = cartManager.getProductQuantity(product.id)
        XCTAssertEqual(expectedQuantity, quantity)
    }
    
    func testRemoveMultipleProducts() throws {
        let firstProduct = try XCTUnwrap(products[0])
        let secondProduct = try XCTUnwrap(products[1])
        let thirdProduct = try XCTUnwrap(products[2])
        let expectedFirstQuantity = 3
        let expectedSecondQuantity = 4
        let expectedThirdQuantity = 5
        
        (1...expectedFirstQuantity + 1).forEach({_ in cartManager.add(firstProduct) })
        (1...expectedSecondQuantity + 1).forEach({_ in cartManager.add(secondProduct) })
        (1...expectedThirdQuantity + 1).forEach({_ in cartManager.add(thirdProduct) })
        
        cartManager.remove(firstProduct)
        cartManager.remove(secondProduct)
        cartManager.remove(thirdProduct)
        
        let firstQuantity = cartManager.getProductQuantity(firstProduct.id)
        let secondQuantity = cartManager.getProductQuantity(secondProduct.id)
        let thirdQuantity = cartManager.getProductQuantity(thirdProduct.id)
        
        XCTAssertEqual(expectedFirstQuantity, firstQuantity)
        XCTAssertEqual(expectedSecondQuantity, secondQuantity)
        XCTAssertEqual(expectedThirdQuantity, thirdQuantity)
    }
    
    func testGetProducts() throws {
        let firstProduct = try XCTUnwrap(products[0])
        let secondProduct = try XCTUnwrap(products[1])
        let expectedQuantity = 2
        
        cartManager.add(firstProduct)
        cartManager.add(secondProduct)
        
        let products = cartManager.getProducts()
        XCTAssertEqual(expectedQuantity, products.count)
    }
    
    func testCartSavedToLocalStorage() throws {
        let firstProduct = try XCTUnwrap(products[0])
        let secondProduct = try XCTUnwrap(products[1])
        let thirdProduct = try XCTUnwrap(products[2])
        let expectedFirstQuantity = 3
        let expectedSecondQuantity = 4
        let expectedThirdQuantity = 5
        
        (1...expectedFirstQuantity).forEach({_ in cartManager.add(firstProduct) })
        (1...expectedSecondQuantity).forEach({_ in cartManager.add(secondProduct) })
        (1...expectedThirdQuantity).forEach({_ in cartManager.add(thirdProduct) })
        
        cartManager.save()
        cartManager.load()
        
        let firstQuantity = cartManager.getProductQuantity(firstProduct.id)
        let secondQuantity = cartManager.getProductQuantity(secondProduct.id)
        let thirdQuantity = cartManager.getProductQuantity(thirdProduct.id)
        
        XCTAssertEqual(expectedFirstQuantity, firstQuantity)
        XCTAssertEqual(expectedSecondQuantity, secondQuantity)
        XCTAssertEqual(expectedThirdQuantity, thirdQuantity)
    }
}
