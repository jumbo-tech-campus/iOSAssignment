//
//  HomeScreenTests.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 31/10/21.
//

import XCTest

final class HomeScreenTests: XCTestCase {

    func testHomeTitle() {
        let viewModel = HomeViewModel()
        XCTAssertEqual(viewModel.title, R.string.localizable.homeNavigationTitle())
    }

    func testHomeOpenSearchScreen() {
        let navigationSpy = SplashScreenNavigationSpy()

        let navigation = UINavigationController()
        let coordinator = HomeCoordinator(presenter: navigation)
        coordinator.delegate = navigationSpy

        let viewModel = HomeViewModel(coordinator: coordinator)
        viewModel.openSearch()

        XCTAssertEqual(navigationSpy.isSearchOpened, true)
    }
}

// MARK: - Home delegate

private final class SplashScreenNavigationSpy: HomeDelegate {

    var isSearchOpened = false

    func openSearchDidPress() {
        isSearchOpened = true
    }
}
