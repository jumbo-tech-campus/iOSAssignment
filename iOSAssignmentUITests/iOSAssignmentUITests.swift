//
//  iOSAssignmentUITests.swift
//  iOSAssignmentUITests
//
//  Created by Spam C. on 1/30/23.
//

import XCTest

final class iOSAssignmentUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testStartScreen() throws {
        app.buttons["Start"].tap()
        XCTAssertTrue(app.tabBars["Tab Bar"].buttons["Products"].exists)
        XCTAssertTrue(app.tabBars["Tab Bar"].buttons["Cart"].exists)
    }
    
    func testAddAndRemoveProducts() throws {
        app.buttons["Start"].tap()
        XCTAssertTrue(app.tabBars["Tab Bar"].buttons["Cart"].exists)
        
        let tablesQuery = app.tables
        tablesQuery.cells.containing(.staticText, identifier:"Bounty Single Reep").buttons["Add"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"Snickers 50gr").buttons["Add"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"Twix - 2 x 25g").buttons["Add"].tap()
               
        app.tabBars["Tab Bar"].buttons["Cart"].tap()
        var badgeValue = app.tabBars["Tab Bar"].buttons["Cart"].value as? String ?? ""
        XCTAssertEqual(badgeValue, "3 items")
        XCTAssertEqual(tablesQuery.cells.count, 3)
        
        tablesQuery.cells.containing(.staticText, identifier:"Bounty Single Reep").buttons["-"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"Snickers 50gr").buttons["-"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"Twix - 2 x 25g").buttons["-"].tap()
        
        badgeValue = app.tabBars["Tab Bar"].buttons["Cart"].value as? String ?? ""
        XCTAssertEqual(badgeValue, "")
        XCTAssertEqual(tablesQuery.cells.count, 0)
    }
}
