//
//  CartScreenTests.swift
//  iOSAssignmentTests
//
//  Created by Jader Nunes on 31/10/21.
//

import XCTest

final class CartScreenTests: XCTestCase {

    /// It was added here to avoid boiler plate in avery test but the best practice is to use an specific mock data for each test
    private let jsonData = """
        {
            "products":[
                {
                    "id":"153500PAK",
                    "title":"Snickers chocolade repen 5 stuks",
                    "prices":{
                        "price":{
                            "currency":"EUR",
                            "amount":236
                        },
                        "unitPrice":{
                            "unit":"kg",
                            "price":{
                                "currency":"EUR",
                                "amount":944
                            }
                        }
                    },
                    "available":true,
                    "productType":"PartOfRetailSet",
                    "nixProduct":false,
                    "quantity":"5 x 50 g",
                    "imageInfo":{
                        "primaryView":[
                            {
                                "url":"https://static-images.jumbo.com/product_images/250320210149_153500PAK-1_180x180.png",
                                "width":180,
                                "height":180
                            },
                            {
                                "url":"https://static-images.jumbo.com/product_images/250320210149_153500PAK-1_720x720.png",
                                "width":720,
                                "height":720
                            },
                            {
                                "url":"https://static-images.jumbo.com/product_images/250320210149_153500PAK-1_360x360.png",
                                "width":360,
                                "height":360
                            }
                        ]
                    },
                    "topLevelCategory":"Koek, gebak, snoep, chips",
                    "topLevelCategoryId":"SG9"
                },
                {
                    "id":"153500PAK",
                    "title":"Snickers chocolade repen 5 stuks",
                    "prices":{
                        "price":{
                            "currency":"EUR",
                            "amount":236
                        },
                        "unitPrice":{
                            "unit":"kg",
                            "price":{
                                "currency":"EUR",
                                "amount":944
                            }
                        }
                    },
                    "available":true,
                    "productType":"PartOfRetailSet",
                    "nixProduct":false,
                    "quantity":"5 x 50 g",
                    "imageInfo":{
                        "primaryView":[
                            {
                                "url":"https://static-images.jumbo.com/product_images/250320210149_153500PAK-1_180x180.png",
                                "width":180,
                                "height":180
                            },
                            {
                                "url":"https://static-images.jumbo.com/product_images/250320210149_153500PAK-1_720x720.png",
                                "width":720,
                                "height":720
                            },
                            {
                                "url":"https://static-images.jumbo.com/product_images/250320210149_153500PAK-1_360x360.png",
                                "width":360,
                                "height":360
                            }
                        ]
                    },
                    "topLevelCategory":"Koek, gebak, snoep, chips",
                    "topLevelCategoryId":"SG9"
                }
            ]
        }
        """.data(using: .utf8) ?? Data()

    override func setUp() {

        super.setUp()
        UserDefaultsMock.resetStandardUserDefaults()
    }

    func testCartTitle() {
        let viewModel = CartViewModel()
        XCTAssertEqual(viewModel.title, R.string.localizable.cartNavigationTitle())
    }

    func testLoadProductsSuccess() {
        do {
            let cart = CartManager(database: DatabaseManager(database: UserDefaultsMock.standard),
                                   notification: NotificationCenter())
            let products = try JSONDecoder.decoder.decode(Products.self, from: jsonData)
            let mock = AFMock(data: products)
            let service = ProductServicesTest(networkManager: mock)
            service.requestAllProducts { response in
                switch response {
                    case .success(let result):
                        result.products.forEach { cart.addProduct($0) }
                    case .failure:
                        XCTFail("Failed")
                }
            }

            let viewModel = CartViewModel(cart: cart)
            viewModel.loadProducts()
            XCTAssertGreaterThan(viewModel.countItems(in: 0), 0)
        } catch {
            XCTFail("Failed to initialize from decoder")
        }
    }

    func testAddProduct() {
        do {
            let cart = CartManager(database: DatabaseManager(database: UserDefaultsMock.standard),
                                   notification: NotificationCenter())
            let products = try JSONDecoder.decoder.decode(Products.self, from: jsonData)
            let mock = AFMock(data: products)
            let service = ProductServicesTest(networkManager: mock)
            let viewModel = CartViewModel(cart: cart)

            service.requestAllProducts { response in
                switch response {
                    case .success(let result):
                        result.products.forEach { viewModel.addProduct($0) }
                    case .failure:
                        XCTFail("Failed")
                }
            }

            XCTAssertEqual(cart.countAll(), 2)
        } catch {
            XCTFail("Failed to initialize from decoder")
        }
    }

    func testRemoveProduct() {
        do {
            let cart = CartManager(database: DatabaseManager(database: UserDefaultsMock.standard),
                                   notification: NotificationCenter())
            let products = try JSONDecoder.decoder.decode(Products.self, from: jsonData)
            let mock = AFMock(data: products)
            let service = ProductServicesTest(networkManager: mock)
            let viewModel = CartViewModel(cart: cart)

            service.requestAllProducts { response in
                switch response {
                    case .success(let result):
                        result.products.forEach { viewModel.addProduct($0) }

                        if let product = result.products.first {
                            viewModel.removeProduct(product)
                            XCTAssertEqual(viewModel.countAllItems(), result.products.count - 1)
                        }
                    case .failure:
                        XCTFail("Failed")
                }
            }
        } catch {
            XCTFail("Failed to initialize from decoder")
        }
    }

    func testTotalCart() {
        do {
            let products = try JSONDecoder.decoder.decode(Products.self, from: jsonData)
            let mock = AFMock(data: products)
            let service = ProductServicesTest(networkManager: mock)
            let cart = Cart()

            service.requestAllProducts { response in
                switch response {
                    case .success(let result):
                        result.products.forEach { cart.addProduct($0) }
                        XCTAssertEqual(cart.calcTotal(), 472)
                    case .failure:
                        XCTFail("Failed")
                }
            }
        } catch {
            XCTFail("Failed to initialize from decoder")
        }
    }

    func testProductService() {
        let service = ProductServices()
        service.requestAllProducts { response in
            switch response {
                case .success(let result):
                    XCTAssertGreaterThan(result.products.count, 0)
                case .failure:
                    XCTFail("Failed")
            }
        }
    }
}
