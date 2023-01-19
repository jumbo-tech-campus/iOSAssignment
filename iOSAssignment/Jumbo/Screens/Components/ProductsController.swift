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
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        if let product = products?[indexPath.row] {
            DispatchQueue.global().async {
                let url = URL(string: product.imageInfo?.primaryView?.smallestImage?.url ?? "")
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    cell.productImageview.image =  UIImage(data: data!)
                }
            }
            
            cell.nameLabel.text = product.title
            cell.descriptionLabel.text = product.quantity
            cell.priceLabel.text = "\(product.prices?.price?.amount ?? 0)"
            cell.priceDetailsLabel.text = "\(product.prices?.unitPrice?.price?.amount ?? 0)/\(product.prices?.unitPrice?.unit ?? "")"
            cell.setQuantity(CartManager.shared.cart[product.id]?.quantity ?? 0)
            cell.didTapAdd = {
                CartManager.shared.add(product)
                cell.setQuantity(CartManager.shared.cart[product.id]?.quantity ?? 0)
            }
            cell.didTapRemove = {
                CartManager.shared.remove(product)
                let quantity = CartManager.shared.cart[product.id]?.quantity ?? 0
                cell.setQuantity(quantity)
                if quantity == 0 {
                    self.loadData()
                }
            }
        }
        return cell
    }
}
