//
//  ProductsController.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/18/23.
//

import UIKit
import Kingfisher

class ProductsController: UITableViewController {
    
    lazy var viewModel: ProductsViewModel = {
        return ProductsControllerViewModel()
    }()
    
    var cartManager: CartManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initBinding()
        viewModel.loadData()
    }
    
    func initView() {
        tableView.register(UINib(nibName: ProductCellViewModel.identifier, bundle: nil), forCellReuseIdentifier: ProductCellViewModel.identifier)
    }
    
    func initBinding() {
        viewModel.cartManager = cartManager
        viewModel.data.addObserver { [weak self ] _ in
            self?.tableView.reloadData()
        }
    }
}

// Table View Delegates
extension ProductsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.value.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ProductCellViewModel.height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCellViewModel.identifier, for: indexPath) as! ProductCell
        let cellViewModel = ProductCellViewModel()
        cellViewModel.product = viewModel.data.value[indexPath.row]
        cellViewModel.cartManager = cartManager
        cell.viewModel = cellViewModel
        cell.setup()
        return cell
    }
}
