//
//  AppCoordinatorTests.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 31/10/21.
//

import XCTest

final class AppCoordinatorTests: XCTestCase {

    func testAppCoordinatorDefaultFlow() {
        let window = UIWindow()
        let coordinator = AppCoordinator(window: window)
        coordinator.start()
        XCTAssertTrue(window.rootViewController is SplashScreenViewController)
    }

    func testAppCoordinatorSearch() {
        let window = UIWindow()
        let coordinator = AppCoordinator(window: window, initialFlow: .mainApp)
        coordinator.start()

        let tabBar = window.rootViewController as? UITabBarController
        let navigation = tabBar?.selectedViewController as? UINavigationController
        XCTAssertTrue(navigation?.visibleViewController is HomeViewController)
    }
}
