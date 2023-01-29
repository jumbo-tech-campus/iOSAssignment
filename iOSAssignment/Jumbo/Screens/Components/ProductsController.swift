//
//  ProductsController.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/18/23.
//

import UIKit
import Kingfisher

protocol Loadable {
    func loadData()
}

class ProductsController: UITableViewController, Loadable {
    
    var products: [ProductRaw]?
    var cartManager: CartManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        let productRepository = ProductsRepository()
        products = productRepository.fetchRawProducts()?.products
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        tableView.reloadData()
    }
    
}

// Table View Delegates
extension ProductsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        if let product = products?[indexPath.row] {
            let url = URL(string: product.imageInfo?.primaryView?.smallestImage?.url ?? "")
            cell.productImageview.kf.setImage(with: url, placeholder: UIImage(named: "logo"))
            
            cell.nameLabel.text = product.title
            cell.descriptionLabel.text = product.quantity
            cell.priceLabel.text = "\(product.prices?.price?.amount ?? 0)"
            cell.priceDetailsLabel.text = "\(product.prices?.unitPrice?.price?.amount ?? 0)/\(product.prices?.unitPrice?.unit ?? "")"
            cell.setQuantity(cartManager.getProductQuantity(product.id))
            cell.didTapAdd = { [weak self] in
                self?.cartManager.add(product)
                if let quantity = self?.cartManager.getProductQuantity(product.id) {
                    cell.setQuantity(quantity)
                }
            }
            cell.didTapRemove = { [weak self] in
                self?.cartManager.remove(product)
                if let quantity = self?.cartManager.getProductQuantity(product.id) {
                    cell.setQuantity(quantity)
                    if quantity == 0 {
                        self?.loadData()
                    }
                }
            }
        }
        return cell
    }
}
