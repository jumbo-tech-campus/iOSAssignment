//
//  ProductCellViewModelTests.swift
//  iOSAssignmentTests
//
//  Created by Rodrigo Ruiz Murguia on 17/02/22.
//

@testable import iOSAssignment
import XCTest

class ProductCellViewModelTests: XCTestCase {

    var productCellViewModel: ProductCellViewModel!
    var product: ProductRaw!
    var viewModelMock: ViewModelMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        viewModelMock = ViewModelMock()
        product = try XCTUnwrap(ProductsRepository().fetchRawProducts()?.products.first)

        productCellViewModel = ProductCellViewModel(product: product,
                                                    productDisplayableViewModel: viewModelMock,
                                                    imageManager: ImageManager(), // Would be nice to create a mock ImageManager
                                                    inCartQuantity: 4)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        viewModelMock = nil
        product = nil
        productCellViewModel = nil
    }

    func testCorrectViewControllerPropertiesAreGenerated() throws {
        let expectedId = product.id
        let expectedTitle = product.title
        let expectedIsQuantityHidden = product.quantity == nil
        let expectedQuantity = "Inhoud: 5 x 50 g"
        let expectedPrice = "€236.00"
        let expectedUnitPrice = "944/kg"

        XCTAssertEqual(expectedId, productCellViewModel.id)
        XCTAssertEqual(expectedTitle, productCellViewModel.name)
        XCTAssertEqual(expectedIsQuantityHidden, productCellViewModel.isQuantityHidden)
        XCTAssertEqual(expectedQuantity, productCellViewModel.quantity)
        XCTAssertEqual(expectedPrice, productCellViewModel.price)
        XCTAssertEqual(expectedUnitPrice, productCellViewModel.unitPrice)

    }

    @MainActor
    func testProductsEvent() {

        let uiActions: [ProductsCellAction] = [
            .removeFromCart, .addToCart, .removeFromCart, .addToCart,
        ]

        let expectedActions = uiActions.map { action -> ProductsControllerAction in
            switch action {
                case .addToCart:
                    return .addToCart(product: product)
                case .removeFromCart:
                    return .removeFromCart(product: product)
            }
        }

        for action in uiActions {
            productCellViewModel.productsEvent(action: action)
        }

        XCTAssertEqual(expectedActions, viewModelMock.reportedEvents)
    }

}
