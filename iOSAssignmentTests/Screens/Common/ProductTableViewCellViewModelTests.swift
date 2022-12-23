//
//  ProductTableViewCellViewModelTests.swift
//  iOSAssignmentTests
//
//  Created by Ramkrishna Baddi on 23/12/2022.
//

@testable import iOSAssignment
import XCTest
import RxCocoa
import RxSwift

final class ProductTableViewCellViewModelTests: XCTestCase {

    private var product: ProductRaw!
    var viewModel: ProductTableViewCellViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        product = try XCTUnwrap(ProductsRepository().fetchRawProducts()?.products.map { $0 }.first )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        product = nil
    }

    func testAddProductInCart() throws {
       let cellEvents = PublishSubject<ProductListVCActions>.init()
       viewModel = ProductTableViewCellViewModel(product: product, cartQuantity: 0, events: cellEvents)
        
        viewModel.productCellAction(action: .addToCart)
        let expectedQuantity = 1
        let actualQuantity = viewModel.getQuantityInCart()
        
        XCTAssertEqual(expectedQuantity, actualQuantity)
    }
    
    func testDeleteProductInCart() throws {
        let cellEvents = PublishSubject<ProductListVCActions>.init()
        viewModel = ProductTableViewCellViewModel(product: product, cartQuantity: 2, events: cellEvents)
        
        viewModel.productCellAction(action: .deleteFromCart)
        let expectedQuantity = 1
        let actualQuantity = viewModel.getQuantityInCart()
        
        XCTAssertEqual(expectedQuantity, actualQuantity)
    }

}
