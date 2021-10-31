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
}
