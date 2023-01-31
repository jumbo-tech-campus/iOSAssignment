//
//  ProductCell.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/18/23.
//

import UIKit

class ProductCell: UITableViewCell {
    var viewModel: ProductCellViewModel!
    
    @IBOutlet weak var productImageview: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceDetailsLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var stepperView: UIStackView!
    
    @IBAction func didTapAdd(_ sender: Any) {
        viewModel.didTapAdd()
    }
    
    @IBAction func didTapRemove(_ sender: Any) {
        viewModel.didTapRemove()
    }
    
    func setup() {
        productImageview.kf.setImage(with: viewModel.imageUrl, placeholder: UIImage(named: "logo"))
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        priceLabel.text = viewModel.price
        priceDetailsLabel.text = viewModel.priceDetails
        viewModel.quantity.addObserver(fireNow: true) { [weak self] quantity in
            if quantity == 0 {
                self?.addToCartButton.isHidden = false
                self?.stepperView.isHidden = true
            } else {
                self?.addToCartButton.isHidden = true
                self?.stepperView.isHidden = false
            }
            self?.quantityLabel.text = "\(quantity)"
        }
    }
}
