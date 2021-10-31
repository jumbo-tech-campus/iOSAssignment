//
//  ProductCellViewModelTests.swift
//  iOSAssignmentTests
//
//  Created by Jader Nunes on 31/10/21.
//

import XCTest

final class ProductCellViewModelTests: XCTestCase {

    func testProductCellSuccess() {
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
            let cellSpy = ProductCellSpy()

            let product = try JSONDecoder.decoder.decode(Product.self, from: json)
            let viewModel = ProductCellViewModel(product: product)
            viewModel.delegate = cellSpy

            XCTAssertEqual(cellSpy.hasProductAdded, false)
            XCTAssertEqual(cellSpy.hasProductRemoved, false)

            viewModel.addProduct()
            XCTAssertEqual(cellSpy.hasProductAdded, true)

            viewModel.removeProduct()
            XCTAssertEqual(cellSpy.hasProductRemoved, true)

        } catch {
            XCTFail("Failed to initialize from decoder")
        }
    }
}

// MARK: - Home delegate

private final class ProductCellSpy: ProductCellContentDelegate {

    var hasProductAdded = false
    var hasProductRemoved = false

    func addButtonPressed(product: Product) {
        hasProductAdded = true
    }

    func removeButtonPressed(product: Product) {
        hasProductRemoved = true
    }
}
