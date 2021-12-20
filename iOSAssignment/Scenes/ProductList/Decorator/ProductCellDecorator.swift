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
    
    static func setupProductCell(cell: ProductCell, indexPath: IndexPath, product: CartProduct, delegate: AddCartDelegate) {
        
        let rawProduct = product.product
        
        if let url = URL(string: rawProduct.imageInfo?.primaryView?.smallestImage?.url ?? "") {
            cell.productView.productImageView.af.setImage(withURL: url)
        }
        
        cell.productView.productNameLabel.text = rawProduct.title
        
        if let quantity = rawProduct.quantity {
            cell.productView.productSizeLabel.text = "Inhoud: \(quantity)"
        }
        
        if let regularPrice = rawProduct.prices?.price, let unitPrice = rawProduct.prices?.unitPrice {
            cell.productView.productPriceView.integerLabel.text = "\(regularPrice.amount)"
            cell.productView.productPriceView.fractionLabel.text = ".-"
            let unit = unitPrice.unit ?? ""
            let price = unitPrice.price?.amount ?? 0
            cell.productView.productPriceView.priceSpecLabel.text = "\(price)/\(unit)"
        }
        
        cell.productView.productAddCartButton.setAmount(product.amount)
        cell.productView.productAddCartButton.delegate = delegate
        cell.productView.productAddCartButton.indexPathToReport = indexPath
    }
}
