//
//  ProductsListTableViewModelTests.swift
//  iOSAssignmentTests
//
//  Created by Ramkrishna Baddi on 23/12/2022.
//

@testable import iOSAssignment
import XCTest
import RxCocoa
import RxSwift


final class ProductsListTableViewModelTests: XCTestCase {

    var cartManager: DiskCacheCartManager!
    var products: [ProductRaw] = []
    var viewModel: ProductsListTableViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        products = try XCTUnwrap(ProductsRepository().fetchRawProducts()?.products.map { $0 } )
        cartManager = DiskCacheCartManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        products = []
        cartManager = nil
    }
    
    func testLoadProductStoreList() throws {
        
        viewModel = ProductsListTableViewModel(state: .store, cartManager: cartManager)
        
        let products = try XCTUnwrap(products)
        let expectedListCount: Int = products.count
        
        viewModel.handleEvents(events: .reload)
        let actualListCount = viewModel.requestProductList().count
        
        XCTAssertEqual(expectedListCount, actualListCount)
    }
    
    func testLoadProductCartList() throws {
        
        let reloadSignal = PublishSubject<Void>()
        viewModel = ProductsListTableViewModel(state: .cart(reloadSignal: reloadSignal), cartManager: cartManager)
        
        let products = try XCTUnwrap(products)
        let expectedListCount: Int = products.count
        
        viewModel.cellEvents.onNext(.reload)
        
        let actualListCount = viewModel.requestProductList().count
        
        XCTAssertEqual(expectedListCount, actualListCount)
    }
    

    func testAddProductsIntoTheCart() throws {
        
        viewModel = ProductsListTableViewModel(state: .store, cartManager: cartManager)
        
        let first = try XCTUnwrap(products.first)
        let expectedQuantity: Int = cartManager.quantity(for: first)
        let newQuantity = 3
        
        (1...newQuantity).forEach({_ in viewModel.handleEvents(events: .addToCart(product: first)) })
        
        let actualQuantity = cartManager.quantity(for: first)
        
        XCTAssertEqual(expectedQuantity + newQuantity, actualQuantity)
    }
    
    func testDeleteProductFromCart() throws {
        
        viewModel = ProductsListTableViewModel(state: .store, cartManager: cartManager)
        
        let first = try XCTUnwrap(products.first)
        var expectedQuantity: Int = cartManager.quantity(for: first)
        let newQuantity = 3
        let deletedQuantity = 1
        
        (1...newQuantity).forEach({_ in viewModel.handleEvents(events: .addToCart(product: first)) })
        
        viewModel.handleEvents(events: .deleteFromCart(product: first))
        
        let actualQuantity = cartManager.quantity(for: first)
        expectedQuantity +=  newQuantity - deletedQuantity
        XCTAssertEqual(expectedQuantity, actualQuantity)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
