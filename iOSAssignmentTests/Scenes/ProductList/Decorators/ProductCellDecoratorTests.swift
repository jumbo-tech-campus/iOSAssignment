//
//  ProductCellDecorator.swift
//  iOSAssignmentTests
//
//  Created by David Velarde on 19/12/2021.
//

import Foundation

@testable import iOSAssignment
import XCTest

class ProductCellDecoratorTests: XCTestCase {
  
    // MARK: Subject under test
    
    var sut: ProductCellDecorator!
    
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Tests
  
    func testGetProductCellNil() {
        // Given
        let tableView = UITableView()
        let indexPath = IndexPath(row: 0, section: 0)
    
        // When
        let cell = ProductCellDecorator.dequeueProductCell(tableView: tableView, indexPath: indexPath)
        
        // Then
        XCTAssertNil(cell, "Product cell decorator should return nil when was not able to dequeue a product cell")
    }
    
    func testGetProductCellNotNil() {
        // Given
        let tableView = UITableView()
        let indexPath = IndexPath(row: 0, section: 0)
    
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        // When
        let cell = ProductCellDecorator.dequeueProductCell(tableView: tableView, indexPath: indexPath)
        
        // Then
        XCTAssertNotNil(cell, "Product cell decorator should return nil when was not able to dequeue a product cell")
    }
    
}
