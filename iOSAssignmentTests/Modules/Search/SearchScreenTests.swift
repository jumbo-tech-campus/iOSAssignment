//
//  SearchScreenTests.swift
//  iOSAssignmentTests
//
//  Created by Jader Nunes on 31/10/21.
//

import XCTest

final class SearchScreenTests: XCTestCase {

    private let json = """
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
                    "id":"15350asasd0PAK",
                    "title":"Snickerakjsdhflkajshdfklhalskdj stuks",
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

    func testSearchTitle() {
        let viewModel = SearchViewModel()
        XCTAssertEqual(viewModel.title, R.string.localizable.searchNavigationTitle())
    }

    func testLoadProductsSuccess() {
        do {
            let products = try JSONDecoder.decoder.decode(Products.self, from: json)
            let mock = AFMock(data: products)
            let service = ProductServicesTest(networkManager: mock)

            let viewModel = SearchViewModel(
                service: service,
                cart: CartManager(database: DatabaseManager(database: UserDefaultsMock.standard),
                                  notification: NotificationCenter())
            )
            viewModel.loadProducts()
            XCTAssertGreaterThan(viewModel.countItems(in: 0), 0)
        } catch {
            XCTFail("Failed to initialize from decoder")
        }
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

        do {
            let products = try JSONDecoder.decoder.decode(Products.self, from: json)
            let mock = AFMock(data: products)
            let service = ProductServicesTest(networkManager: mock)
            let viewModel = SearchViewModel(
                service: service,
                cart: CartManager(database: DatabaseManager(database: UserDefaultsMock.standard),
                                  notification: NotificationCenter())
            )
            viewModel.loadProducts()
            viewModel.search(text: textToSearch)
            XCTAssertGreaterThan(viewModel.countItems(in: 0), 0)

            let viewModelProduct = viewModel.viewModel(for: 0)
            XCTAssertEqual(viewModelProduct?.product.title, textToSearch)
        } catch {
            XCTFail("Failed to initialize from decoder")
        }
    }

    func testAddProduct() {
        do {
            let products = try JSONDecoder.decoder.decode(Products.self, from: json)
            let mock = AFMock(data: products)
            let service = ProductServicesTest(networkManager: mock)
            let cart = CartManager(database: DatabaseManager(database: UserDefaultsMock.standard),
                                   notification: NotificationCenter())

            let viewModel = SearchViewModel(service: service, cart: cart)
            viewModel.loadProducts()
            XCTAssertEqual(cart.countAll(), 0)

            let product = viewModel.viewModel(for: 0)?.product
            XCTAssertNotNil(product)

            if let product = product {
                viewModel.addProduct(product)
                XCTAssertEqual(cart.countAll(), 1)
            }
        } catch {
            XCTFail("Failed to initialize from decoder")
        }
    }

    func testRemoveProduct() {
        do {
            let products = try JSONDecoder.decoder.decode(Products.self, from: json)
            let mock = AFMock(data: products)
            let service = ProductServicesTest(networkManager: mock)

            let cart = CartManager(database: DatabaseManager(database: UserDefaultsMock.standard),
                                   notification: NotificationCenter())

            let viewModel = SearchViewModel(service: service, cart: cart)
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
        } catch {
            XCTFail("Failed to initialize from decoder")
        }
    }
}
