//
//  SearchScreenTests.swift
//  iOSAssignmentTests
//
//  Created by Jader Nunes on 31/10/21.
//

import XCTest

final class SearchScreenTests: XCTestCase {

    override func setUp() {

        super.setUp()
        UserDefaultsMock.resetStandardUserDefaults()
    }

    func testSearchTitle() {
        let viewModel = SearchViewModel()
        XCTAssertEqual(viewModel.title, R.string.localizable.searchNavigationTitle())
    }

    func testLoadProductsSuccess() {
        let mock = ProductServiceResponseSuccess()
        let viewModel = SearchViewModel(
            service: mock,
            cart: CartManager(database: DatabaseManager(database: UserDefaultsMock.standard),
                              notification: NotificationCenter())
        )
        viewModel.loadProducts()
        XCTAssertGreaterThan(viewModel.countItems(in: 0), 0)
    }

    func testLoadProductsError() {
        let mock = ProductServiceResponseError()
        let viewModel = SearchViewModel(
            service: mock,
            cart: CartManager(database: DatabaseManager(database: UserDefaultsMock.standard),
                              notification: NotificationCenter())
        )
        viewModel.loadProducts()
        XCTAssertEqual(viewModel.countItems(in: 0), 0)
        XCTAssertNotNil(viewModel.messageData.value)
    }

    func testSearchData() {
        let textToSearch = "Snickers chocolade repen 5 stuks"
        let mock = ProductServiceResponseSuccess()

        let viewModel = SearchViewModel(
            service: mock,
            cart: CartManager(database: DatabaseManager(database: UserDefaultsMock.standard),
                              notification: NotificationCenter())
        )
        viewModel.loadProducts()
        viewModel.search(text: textToSearch)
        XCTAssertEqual(viewModel.countItems(in: 0), 1)

        let viewModelProduct = viewModel.viewModel(for: 0)
        XCTAssertEqual(viewModelProduct?.product.title, textToSearch)
    }

    func testAddProduct() {
        let mock = ProductServiceResponseSuccess()
        let cart = CartManager(database: DatabaseManager(database: UserDefaultsMock.standard),
                               notification: NotificationCenter())

        let viewModel = SearchViewModel(service: mock, cart: cart)
        viewModel.loadProducts()
        XCTAssertEqual(cart.countAll(), 0)

        let product = viewModel.viewModel(for: 0)?.product
        XCTAssertNotNil(product)

        if let product = product {
            viewModel.addProduct(product)
            XCTAssertEqual(cart.countAll(), 1)
        }
    }

    func testRemoveProduct() {
        let mock = ProductServiceResponseSuccess()
        let cart = CartManager(database: DatabaseManager(database: UserDefaultsMock.standard),
                               notification: NotificationCenter())

        let viewModel = SearchViewModel(service: mock, cart: cart)
        viewModel.loadProducts()

        let viewModelPA = viewModel.viewModel(for: 0)
        let viewModelPB = viewModel.viewModel(for: 1)

        XCTAssertNotNil(viewModelPA?.product)
        XCTAssertNotNil(viewModelPB?.product)

        guard
            let productA = viewModelPA?.product,
            let productB = viewModelPB?.product
            else { return }

        viewModel.addProduct(productA)
        XCTAssertEqual(cart.countAll(), 1)

        viewModel.addProduct(productB)
        XCTAssertEqual(cart.countAll(), 2)

        viewModel.removeProduct(productA)
        XCTAssertEqual(cart.countAll(), 1)
    }
}
