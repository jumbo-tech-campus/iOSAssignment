//
//  ProductCellWide.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 16/02/22.
//

import UIKit

class ProductCellWide: UITableViewCell, ProductCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var unitPrice: UILabel!
    @IBOutlet weak var cartQuantity: UILabel!
    @IBOutlet weak var cartQuantityContainer: UIView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var removeFromCartButton: UIButton!

    var viewModel: ProductCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func addToCartPressed(_ sender: UIButton) {
        var x = cartQuantityContainer.isHidden
        x.toggle()
        cartQuantityContainer.isHidden = x
    }
    
}
