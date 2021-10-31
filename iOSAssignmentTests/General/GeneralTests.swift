//
//  GeneralTests.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 31/10/21.
//

import XCTest

final class GeneralTests: XCTestCase {

    func testSceneDelegateData() {
        let appDelegate = SceneDelegate(window: UIWindow())
        XCTAssertNotNil(appDelegate.window)
    }

    func testClassObject() {
        class Object: NSObject, Coordinator {}
        let ref = Object()
        XCTAssertEqual(ref.className, "Object")
    }

    func testErrorRequest() {
        var error: ErrorRequest = .custom(message: "custom")
        XCTAssertEqual(error.message, "custom")

        error = .generic(message: "generic")
        XCTAssertEqual(error.message, "generic")

        error = .noInternet(message: "noInternet")
        XCTAssertEqual(error.message, "noInternet")
    }
}
