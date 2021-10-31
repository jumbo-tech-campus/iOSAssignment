//
//  ProductTests.swift
//  iOSAssignmentTests
//
//  Created by Jader Nunes on 31/10/21.
//

import XCTest

final class ProductTests: XCTestCase {

    func testProductDecoderInit() {
        let json = """
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
        """.data(using: .utf8) ?? Data()

        do {
            let product = try JSONDecoder.decoder.decode(Product.self, from: json)
            XCTAssertEqual(product.id, "153500PAK")
            XCTAssertEqual(product.title, "Snickers chocolade repen 5 stuks")
        } catch {
            XCTFail("Failed to initialize from decoder")
        }
    }
}
