//
//  UITableViewTests.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 31/10/21.
//

import XCTest

final class UITableViewTests: XCTestCase {

    func testRegisterCells() {
        let table = UITableView()
        table.registerClass(cellType: ProductCell.self)
        let cell = table.dequeueReusableCell(with: ProductCell.self, for: IndexPath())
        XCTAssertNotNil(cell)
    }
}
