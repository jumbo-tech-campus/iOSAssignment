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
    
    var didTapAdd: (() -> Void)?
    var didTapRemove: (() -> Void)?
    
    @IBAction func didTapAdd(_ sender: Any) {
        didTapAdd?()
    }
    
    @IBAction func didTapRemove(_ sender: Any) {
        didTapRemove?()
    }
    
    func setup() {
        productImageview.kf.setImage(with: viewModel.imageUrl, placeholder: UIImage(named: "logo"))
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        priceLabel.text = viewModel.price
        priceDetailsLabel.text = viewModel.priceDetails
        setQuantity(viewModel.getProductQuantity())
        didTapAdd = { [weak self] in
            if let self = self {
                self.setQuantity(self.viewModel.didTapAdd())
            }
        }
        didTapRemove = { [weak self] in
            if let self = self {
                self.setQuantity(self.viewModel.didTapRemove())
            }
        }
    }
    
    func setQuantity(_ quantity: Int) {
        if quantity == 0 {
            addToCartButton.isHidden = false
            stepperView.isHidden = true
        } else {
            addToCartButton.isHidden = true
            stepperView.isHidden = false
        }
        
        quantityLabel.text = "\(quantity)"
    }
}
