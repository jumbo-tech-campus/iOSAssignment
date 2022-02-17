//
//  ProductCellStretch.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 16/02/22.
//

import UIKit

class ProductCellStretch: UITableViewCell, ProductCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var unitPrice: UILabel!
    @IBOutlet weak var cartQuantity: UILabel!
    @IBOutlet weak var cartQuantityContainer: UIView!
    @IBOutlet weak var addToCartButton: UIButton!
    var removeFromCartButton: UIButton! // left unused on purpose

    var viewModel: ProductCellViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func addToCartPressed(_ sender: UIButton) {
        var x = cartQuantityContainer.isHidden
        x.toggle()
        cartQuantityContainer.isHidden = x
    }
}

class ProductCellViewModel: Hashable {

    let product: ProductRaw

    var productImage: UIImage? { parseImage() }
    var name: String { product.title }
    var isQuantityHidden: Bool { product.quantity == nil }
    var quantity: String { formatQuantity() }
    var price: String { formatPrice() }
    var unitPrice: String { formatUnitPrice() }
    var cartQuantity: String? { (0...1).randomElement() == 0 ? nil : "1" }

    init(product: ProductRaw) {
        self.product = product
    }

    // MARK: - Data processing
    func parseImage() -> UIImage? {
        return UIImage(systemName: "hexagon.fill")

        //        guard let primaryView = product.imageInfo?.primaryView,
        //              let imageDetail = primaryView.first,
        //              let url = URL(string: imageDetail.url) else {
        //                  return UIImage(systemName: "hexagon.fill")
        //              }
    }

    func formatPrice() -> String {
        guard let price = product.prices?.price?.amount.description else {
            // I don't think price should be nullable
            // but in case they should we could do something like `isQuantityHidden`
            return ""
        }

        return price
    }

    func formatUnitPrice() -> String {
        guard let unitPrice = product.prices?.unitPrice,
              let unit = unitPrice.unit,
              let price = unitPrice.price?.amount else {
                  // I don't think these should be nullable
                  // but in case they should we could do something like `isQuantityHidden`
                  return ""
              }

        return "\(price)/\(unit)"
    }

    func formatQuantity() -> String {
        guard let quantity = product.quantity else {
            return ""
        }

        return "Inhoud: \(quantity)"
    }


    // MARK: - Hashable conformance
    static func == (lhs: ProductCellViewModel, rhs: ProductCellViewModel) -> Bool {
        lhs.product.id == rhs.product.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(product.id)
    }
}
