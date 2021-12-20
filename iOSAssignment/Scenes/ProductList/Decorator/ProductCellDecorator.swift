//
//  ProductCellDecorator.swift
//  iOSAssignment
//
//  Created by David Velarde on 19/12/2021.
//

import UIKit
import AlamofireImage

enum ProductCellDecorator {
    
    static func getCurrentCell(tableView: UITableView, indexPath: IndexPath) -> ProductCell? {
        return tableView.cellForRow(at: indexPath) as? ProductCell
    }
    
    static func dequeueProductCell(tableView: UITableView, indexPath: IndexPath) -> ProductCell? {
        return tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier) as? ProductCell
    }
    
    static func setupProductCell(cell: ProductCell, indexPath: IndexPath, product: CartProduct, delegate: AddCartDelegate) {
        
        let rawProduct = product.product
        
        if let url = URL(string: rawProduct.imageInfo?.primaryView?.smallestImage?.url ?? "") {
            cell.productView.productImageView.af.setImage(withURL: url)
        }
        
        cell.productView.productNameLabel.text = rawProduct.title
        
        if let quantity = rawProduct.quantity {
            cell.productView.productSizeLabel.text = quantity
        }
        
        if let regularPrice = rawProduct.prices?.price, let unitPrice = rawProduct.prices?.unitPrice {
            cell.productView.productPriceView.integerLabel.text = "\(regularPrice.amount)"
            cell.productView.productPriceView.fractionLabel.text = ".-"
            let unit = unitPrice.unit ?? ""
            let price = unitPrice.price?.amount ?? 0
            cell.productView.productPriceView.priceSpecLabel.text = "\(price)/\(unit)"
        }
        
        updateCellAmount(cell: cell, product: product)
        cell.productView.productAddCartButton.delegate = delegate
        cell.productView.productAddCartButton.indexPathToReport = indexPath
    }
    
    static func updateCellAmount(cell: ProductCell, product: CartProduct) {
        cell.productView.productAddCartButton.setAmount(product.amount)
    }
}
