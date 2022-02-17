//
//  ProductCell.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 16/02/22.
//

import UIKit

protocol ProductCell: UITableViewCell {

    // MARK: - UITableView registration
    static var identifier: String { get }
    static var nib: UINib { get }

    // MARK: - Required @IBOutlet
    var productImage: UIImageView! { get set }
    var name: UILabel! { get set }
    var quantity: UILabel! { get set }
    var price: UILabel! { get set }
    var unitPrice: UILabel! { get set }
    var cartQuantity: UILabel! { get set }
    var cartQuantityContainer: UIView! { get set }
    var addToCartButton: UIButton! { get set }
    var removeFromCartButton: UIButton! { get set }

    // MARK: - Cell configuration
    var viewModel: ProductCellViewModel? { get set }

    func setUp(viewModel: ProductCellViewModel)
}

extension ProductCell {
    static var identifier: String { String(describing: Self.self) }
    static var nib: UINib { UINib(nibName: identifier, bundle: .main) }

    func setUp(viewModel: ProductCellViewModel) {
        self.viewModel = viewModel
        addToCartButton.setTitle("", for: .normal)
        removeFromCartButton?.setTitle("", for: .normal)
        productImage.image = viewModel.productImage
        name.text = viewModel.name
        quantity.isHidden = viewModel.isQuantityHidden
        quantity.text = viewModel.quantity
        price.text = viewModel.price
        unitPrice.text = viewModel.unitPrice

        if let cartQuantityCount = viewModel.cartQuantity {
            cartQuantityContainer.isHidden = false
            cartQuantity.text = cartQuantityCount
        } else {
            cartQuantityContainer.isHidden = true
        }

    }

    @MainActor
    func addToCart() {
        guard let viewModel = viewModel else { return }
        viewModel.productsEvent(action: .addToCart)
    }

    @MainActor
    func removeFromCart() {
        guard let viewModel = viewModel else { return }
        viewModel.productsEvent(action: .removeFromCart)
    }

}
