//
//  ProductsControllerViewModelTests.swift
//  iOSAssignmentTests
//
//  Created by Spam C. on 1/30/23.
//

@testable import iOSAssignment
import XCTest

final class ProductsControllerViewModelTests: XCTestCase {
    
    var cartManager: CartManager!
    var products: [ProductRaw]!
    var viewModel: ProductsControllerViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cartManager = CartManager()
        let productRepository = ProductsRepository()
        products = productRepository.fetchRawProducts()?.products
        viewModel = ProductsControllerViewModel()
        viewModel.cartManager = cartManager
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cartManager = nil
        products = nil
        viewModel = nil
    }
    
    func testLoadData() throws {
        viewModel.loadData()
        let expectedQuantity = products.count
        XCTAssertEqual(expectedQuantity, viewModel.data.value.count)
    }
}
