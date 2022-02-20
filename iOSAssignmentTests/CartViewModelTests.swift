//
//  CartViewModelTests.swift
//  iOSAssignmentTests
//
//  Created by Rodrigo Ruiz Murguia on 17/02/22.
//

import Combine
@testable import iOSAssignment
import XCTest

class CartViewModelTests: XCTestCase {

    var products: [ProductRaw]!
    var cartViewModel: CartViewModel!
    var cartManager: MemoryCartManager!
    var task: Task<Void, Never>!

    @MainActor
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        products = try XCTUnwrap(ProductsRepository().fetchRawProducts()?.products)
        let imageManager = ImageManager() // Would be nice to create a mock ImageManager
        cartManager = MemoryCartManager()
        products.forEach(cartManager.addToCart(product:)) // add all items to cart to have exactly one for each
        task = Task {
            cartViewModel = await CartViewModel(products: products,
                                                imageManager: imageManager,
                                                cartManager: cartManager)
        }
    }

    @MainActor
    override func tearDownWithError() throws {
        try super.tearDownWithError()

        cartViewModel = nil
        cartManager = nil
        task = nil
        products = nil
    }


    func testRemovingLastItemFromCartDeletesItFromDataSource() async throws {
        _ = await task.value // wait to cartViewModel to load

        let productToRemove = products[0]

        let expectation = XCTestExpectation(description: "Wait for viewModel to report deleted item")
        let cancellable = cartViewModel.$products.dropFirst().sink { products in
            XCTAssertTrue(self.products.contains(productToRemove))
            XCTAssertFalse(products.map(\.product).contains(productToRemove))
            expectation.fulfill()
        }

        await cartViewModel.productsEvent(action: .removeFromCart(product: productToRemove))
        wait(for: [expectation], timeout: 10)
        cancellable.cancel()
    }
}
