//
//  SymbolTests.swift
//  iOSAssignmentTests
//
//  Created by Jader Nunes on 31/10/21.
//

import XCTest

final class SymbolTests: XCTestCase {

    func testSymbolOptions() {
        let allCases = Symbol.allCases
        let enumeratedCases: [Symbol] = [.euro, .unowned]

        XCTAssertEqual(Symbol.allCases.count, 2)
        let fistCase = Symbol.allCases.first
        XCTAssertEqual(fistCase?.value(), "€")

        allCases.forEach {
            XCTAssertEqual(enumeratedCases.contains($0), true)
        }
    }
}
