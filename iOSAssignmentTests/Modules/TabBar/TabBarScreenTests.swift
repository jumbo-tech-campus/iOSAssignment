//
//  TabBarScreenTests.swift
//  iOSAssignmentTests
//
//  Created by Jader Nunes on 31/10/21.
//

import XCTest

final class TabBarScreenTests: XCTestCase {

    override func setUp() {

        super.setUp()
        UserDefaultsMock.resetStandardUserDefaults()
    }

    func testLoadProductsSuccess() {
        let productsResult = JSONResponse.getProductsResponse()
        let cart = CartManager(database: DatabaseManager(database: UserDefaultsMock.standard),
                               notification: NotificationCenter())

        productsResult?.products.forEach { cart.addProduct($0) }

        let viewModel = TabBarViewModel(cart: cart)
        XCTAssertNotNil(viewModel.badgeValue)
    }
}
