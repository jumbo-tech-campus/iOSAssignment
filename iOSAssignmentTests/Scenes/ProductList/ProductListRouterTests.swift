//
//  ProductListRouterTests.swift
//  iOSAssignmentTests
//
//  Created by David Velarde on 18/12/2021.
//

@testable import iOSAssignment
import XCTest

class ProductListRouterTests: XCTestCase {

    // MARK: Subject under test
  
    var sut: ProductListRouter!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupProductListRouter()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
    
    class NavigationControllerSpy: UINavigationController {
        
        var didPopViewController = false
        
        override func popViewController(animated: Bool) -> UIViewController? {
            didPopViewController = true
            return super.popViewController(animated: false)
        }
    }
  
    func setupProductListRouter() {
        sut = ProductListRouter()
    }
  
    // MARK: Tests
  
    func testGoingBack() {
        
        let originVC = UIViewController()
        let spy = NavigationControllerSpy(rootViewController: originVC)
        let currentVC = ProductListViewController()
        spy.pushViewController(currentVC, animated: false)
        sut.viewController = currentVC
        
        sut.routeToWelcome()

        XCTAssertTrue(spy.didPopViewController, "Should have pop'ed the current view controller in the navigation controller")
        XCTAssertEqual(spy.visibleViewController, originVC, "Product List View Controller should not be visible anymore")
        
    }
}
