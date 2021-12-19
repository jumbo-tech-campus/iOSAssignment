//
//  ProductCell.swift
//  iOSAssignment
//
//  Created by David Velarde on 19/12/2021.
//

import UIKit

enum ProductCellState {
    case normal
    case interaction
}

class ProductCell: UITableViewCell {
    var state: ProductCellState = .normal
}
