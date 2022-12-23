//
//  ProductsListVCViewModelTests.swift
//  iOSAssignmentTests
//
//  Created by Ramkrishna Baddi on 23/12/2022.
//

@testable import iOSAssignment
import XCTest
import RxCocoa
import RxSwift


final class ProductsListVCViewModelTests: XCTestCase {

    let disposeBag = DisposeBag()
    
    var viewModel: StoreListVCViewModel!
    var tableViewVM: ProductsListTableViewModel?
    let presentCartSignal = PublishSubject<CartListVCViewModel>()
    let updateCartBadgeSignal = PublishSubject<Int>.init()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        viewModel = StoreListVCViewModel()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadStoreProduct() {
        viewModel.tableViewVM?.sectionsModels.skip(1).asObservable() .subscribe(onNext: { sections in
            XCTAssertEqual(sections.count > 0, true)
        }).disposed(by: disposeBag)
    }

    func testStoreUpdateOnChangesInCart() throws {
        var product: ProductRaw!
        product = try XCTUnwrap(ProductsRepository().fetchRawProducts()?.products.map { $0 }.first )
        
     
        let cartVM = ProductsListTableViewModel(state: .cart(reloadSignal: viewModel.reloadSignal))
        
        let expectReloadSignal = expectation(description: "Cart is being updated...")
        
        viewModel.reloadSignal
            .subscribe(onNext: { _ in
                expectReloadSignal.fulfill()
            }).disposed(by: disposeBag)
        
        cartVM.handleEvents(events: .addToCart(product: product))
        
        
        wait(for: [expectReloadSignal], timeout: 2)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
