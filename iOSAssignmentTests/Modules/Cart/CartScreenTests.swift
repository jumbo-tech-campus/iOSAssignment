//
//  CartScreenTests.swift
//  iOSAssignmentTests
//
//  Created by Jader Nunes on 31/10/21.
//

import XCTest

final class CartScreenTests: XCTestCase {

    override func setUp() {

        super.setUp()
        UserDefaultsMock.resetStandardUserDefaults()
    }

    func testCartTitle() {
        let viewModel = CartViewModel()
        XCTAssertEqual(viewModel.title, R.string.localizable.cartNavigationTitle())
    }

    func testLoadProductsSuccess() {
        let cart = CartManager(database: DatabaseManager(database: UserDefaultsMock.standard),
                               notification: NotificationCenter())

        let mock = ProductServiceResponseSuccess()
        mock.requestAllProducts { response in
            switch response {
                case .success(let result):
                    result.products.forEach { cart.addProduct($0) }
                case .failure: break
            }
        }

        let viewModel = CartViewModel(cart: cart)
        viewModel.loadProducts()
        XCTAssertGreaterThan(viewModel.countItems(in: 0), 0)
    }

    func testAddProduct() {
        let cart = CartManager(database: DatabaseManager(database: UserDefaultsMock.standard),
                               notification: NotificationCenter())


        let mock = ProductServiceResponseSuccess()
        let viewModel = CartViewModel(cart: cart)
        viewModel.loadProducts()

        mock.requestAllProducts { response in
            switch response {
                case .success(let result):
                    result.products.forEach { cart.addProduct($0) }
                case .failure: break
            }
        }

        XCTAssertGreaterThan(cart.countAll(), 2)
    }

    func testRemoveProduct() {
        let cart = CartManager(database: DatabaseManager(database: UserDefaultsMock.standard),
                               notification: NotificationCenter())

        let mock = ProductServiceResponseSuccess()
        let viewModel = CartViewModel(cart: cart)

        mock.requestAllProducts { response in
            switch response {
                case .success(let result):
                    result.products.forEach { viewModel.addProduct($0) }

                    if let product = result.products.first {
                        viewModel.removeProduct(product)
                        XCTAssertEqual(viewModel.countAllItems(), result.products.count - 1)
                    }
                case .failure: break
            }
        }
    }
}
