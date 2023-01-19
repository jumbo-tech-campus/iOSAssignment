//
//  ProductCell.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/18/23.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet weak var productImageview: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceDetailsLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    var didTapAdd: (() -> Void)?
    var didTapRemove: (() -> Void)?
    
    @IBAction func didTapAdd(_ sender: Any) {
        didTapAdd?()
    }
    
    @IBAction func didTapRemove(_ sender: Any) {
        didTapRemove?()
    }
}
