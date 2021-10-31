//
//  SplashScreenFlowTests.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 31/10/21.
//

import XCTest

final class SplashScreenFlowTests: XCTestCase {

    func testSplashScreenNavigations() {
        let window = UIWindow()
        let coordinator = SplashScreenCoordinator(presenter: window)
        coordinator.start()

        XCTAssertTrue(window.rootViewController is SplashScreenViewController)
    }

    func testSplashScreenCoordinatorFlow() {
        let window = UIWindow()
        let appCoordinator = AppCoordinator(window: window)
        let coordinator = SplashScreenCoordinator(presenter: window)
        coordinator.delegate = appCoordinator

        let viewModel = SplashScreenViewModel(coordinator: coordinator)
        viewModel.openMainApp()

        let tabBar = window.rootViewController as? UITabBarController
        let navigation = tabBar?.selectedViewController as? UINavigationController
        XCTAssertTrue(navigation?.visibleViewController is HomeViewController)
    }
}
