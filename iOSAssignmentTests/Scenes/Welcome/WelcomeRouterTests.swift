//
//  WelcomeRouterTests.swift
//  iOSAssignmentTests
//
//  Created by David Velarde on 18/12/2021.
//

@testable import iOSAssignment
import XCTest

class WelcomeRouterTests: XCTestCase {

    // MARK: Subject under test
  
    var sut: WelcomeRouter!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupWelcomeRouter()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
    
    class NavigationControllerSpy: UINavigationController {
        var didPushViewController = false
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            didPushViewController = true
            super.pushViewController(viewController, animated: false)
        }
    }
  
    func setupWelcomeRouter() {
        sut = WelcomeRouter()
    }
  
    // MARK: Tests
  
    func testProductListViewOpens() {
        
        let originVC = WelcomeViewController()
        let spy = NavigationControllerSpy(rootViewController: originVC)
        
        sut.viewController = originVC
        
        sut.routeToProductList()
        
        XCTAssertTrue(spy.didPushViewController, "Should have pushed another view controller in the navigation controller")
        XCTAssertTrue(spy.visibleViewController is ProductListViewController, "Product List View Controller should be visible")
        
    }
}
