//
//  ProductCellDecorator.swift
//  iOSAssignment
//
//  Created by David Velarde on 19/12/2021.
//

import UIKit
import AlamofireImage

enum ProductCellDecorator {
    
    static func dequeueProductCell(tableView: UITableView, indexPath: IndexPath) -> ProductCell? {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier) as? ProductCell else {
            return nil
        }
        return cell
    }
    
    static func setupProductCell(cell: ProductCell, product: CartProduct) {
        
        let product = product.product
        
        if let url = URL(string: product.imageInfo?.primaryView?.smallestImage?.url ?? "") {
            cell.productView.productImageView.af.setImage(withURL: url)
        }
        
        cell.productView.productNameLabel.text = product.title
        
        if let quantity = product.quantity {
            cell.productView.productSizeLabel.text = "Inhoud: \(quantity)"
        }
        
        if let regularPrice = product.prices?.price, let unitPrice = product.prices?.unitPrice {
            cell.productView.productPriceView.integerLabel.text = "\(regularPrice.amount)"
            cell.productView.productPriceView.fractionLabel.text = ".-"
            let unit = unitPrice.unit ?? ""
            let price = unitPrice.price?.amount ?? 0
            cell.productView.productPriceView.priceSpecLabel.text = "\(price)/\(unit)"
        }
        
    }
}
