//
//  ProductCellViewModelTests.swift
//  iOSAssignmentTests
//
//  Created by Spam C. on 1/30/23.
//

@testable import iOSAssignment
import XCTest

final class ProductCellViewModelTests: XCTestCase {
    var viewModel: ProductCellViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let cartManager = CartManager()
        let productRepository = ProductsRepository()
        let products = productRepository.fetchRawProducts()?.products
        viewModel = ProductCellViewModel()
        viewModel.cartManager = cartManager
        viewModel.product = products?.first
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func testUISetup() throws {
        let product = viewModel.product
        XCTAssertEqual(product?.title, viewModel.name)
        XCTAssertEqual(product?.quantity, viewModel.description)
        XCTAssertEqual("\(product?.prices?.price?.amount ?? 0)", viewModel.price)
        XCTAssertEqual("\(product?.prices?.unitPrice?.price?.amount ?? 0)/\(product?.prices?.unitPrice?.unit ?? "")", viewModel.priceDetails)
        XCTAssertEqual(URL(string: product?.imageInfo?.primaryView?.smallestImage?.url ?? ""), viewModel.imageUrl)
    }
    
    func testDidTapAdd() throws {
        viewModel.didTapAdd()
        let expectedQuantity = 1
        XCTAssertEqual(expectedQuantity, viewModel.quantity.value)
    }
    
    func testDidTapRemove() throws {
        viewModel.didTapAdd()
        viewModel.didTapAdd()
        viewModel.didTapRemove()
        let expectedQuantity = 1
        XCTAssertEqual(expectedQuantity, viewModel.quantity.value)
    }
}
