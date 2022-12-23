//
//  ProductCellProtocol.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 18/12/2022.
//

import Foundation
import UIKit

protocol ProductCellProtocol: UITableViewCell {

    // MARK:
    // Required to display cell info
    var productImage: UIImageView! { get set }
    var name: UILabel! { get set }
    var quantity: UILabel! { get set }
    var price: UILabel! { get set }
    var unitPrice: UILabel! { get set }

    // MARK:
    //
    var viewModel: ProductTableViewCellViewModel? { get set }

    func setUp(viewModel: ProductTableViewCellViewModel)
}

extension ProductCellProtocol {

    func setUp(viewModel: ProductTableViewCellViewModel) {
        self.viewModel = viewModel
        name.text = viewModel.name
        quantity.isHidden = viewModel.isQuantityHidden
        quantity.text = viewModel.quantity
        price.text = viewModel.price
        unitPrice.text = viewModel.unitPrice
    }
}
