//
//  ProductsController.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/18/23.
//

import UIKit

class ProductsController: UITableViewController {
    
    var products: [ProductRaw]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        let productRepository = ProductsRepository()
        products = productRepository.fetchRawProducts()?.products
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        if let product = products?[indexPath.row] {
            let url = URL(string: product.imageInfo?.primaryView?.smallestImage?.url ?? "")
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            cell.productImageview.image =  UIImage(data: data!)
            cell.nameLabel.text = product.title
            cell.descriptionLabel.text = product.quantity
            cell.priceLabel.text = "\(product.prices?.price?.currency ?? "") \(product.prices?.price?.amount ?? 0)"
            cell.priceDetailsLabel.text = "\(product.prices?.unitPrice?.price?.amount ?? 0)/\(product.prices?.unitPrice?.unit ?? "")"
        }
        return cell
    }
}