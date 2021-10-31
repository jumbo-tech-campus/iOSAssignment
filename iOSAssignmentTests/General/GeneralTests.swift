//
//  GeneralTests.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 31/10/21.
//

import XCTest

final class GeneralTests: XCTestCase {

    func testSceneDelegateData() {
        let appDelegate = SceneDelegate(window: UIWindow())
        XCTAssertNotNil(appDelegate.window)
    }

    func testClassObject() {
        class Object: NSObject, Coordinator {}
        let ref = Object()
        XCTAssertEqual(ref.className, "Object")
    }

    func testCurrencyFormatEuro() {
        let value = 123
        let valueFormatted = value.toCurrency(locale: Locale(identifier: "tests"), symbol: .euro)
        XCTAssertEqual(valueFormatted, "€ 1.23")
    }

    func testCurrencyFormat() {
        let value = 123
        let valueFormatted = value.toCurrency(locale: Locale(identifier: "tests"))
        XCTAssertEqual(valueFormatted, " 1.23")
    }

    func testErrorRequest() {
        var error: ErrorRequest = .custom(message: "custom")
        XCTAssertEqual(error.message, "custom")

        error = .generic(message: "generic")
        XCTAssertEqual(error.message, "generic")

        error = .noInternet(message: "noInternet")
        XCTAssertEqual(error.message, "noInternet")
    }

    func testResourcesProduct() {
        let resources: ProductResources = .requestAllProducts
        XCTAssertEqual(resources.method, .get)
        XCTAssertEqual(resources.path, "/products")
    }

    func testEncodableJson() {
        let json = """
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
                }
            ]
        }
        """.data(using: .utf8) ?? Data()

        do {
            let products = try JSONDecoder.decoder.decode(Products.self, from: json)
            XCTAssertGreaterThan(products.toJson().keys.count, 0)
        } catch {
            XCTFail("Failed to initialize from decoder")
        }
    }
}
