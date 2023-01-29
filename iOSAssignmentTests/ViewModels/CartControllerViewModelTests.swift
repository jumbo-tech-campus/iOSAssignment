//
//  CartControllerViewModel.swift
//  iOSAssignmentTests
//
//  Created by Spam C. on 1/30/23.
//

@testable import iOSAssignment
import XCTest

final class CartControllerViewModelTests: XCTestCase {
    var cartManager: CartManager!
    var products: [ProductRaw]!
    var viewModel: CartControllerViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cartManager = CartManager()
        let productRepository = ProductsRepository()
        products = productRepository.fetchRawProducts()?.products
        viewModel = CartControllerViewModel()
        viewModel.cartManager = cartManager
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cartManager = nil
        products = nil
    }
    
    func testLoadData() throws {
        let product = try XCTUnwrap(products.first)
        cartManager.add(product)
        viewModel.loadData()
        XCTAssertEqual(cartManager.cart.value.count, viewModel.data.value.count)
    }
}
