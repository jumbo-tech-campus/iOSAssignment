//
//  ProductsListVCViewController.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//  
//

import UIKit

final class ProductsListVC: BaseViewController<ProductsListVCViewModel> {
    
    lazy var contentView: UIView = {
        let view = UIView()
        view .backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: ProductsListTableView = {
        let view = ProductsListTableView()
        view.viewModel = viewModel.tableViewVM
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func bind() {
        
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(contentView)
        contentView.addSubview(tableView)
        configureConstraint()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let cartButton = BadgedButtonItem(with: UIImage.init(systemName: "cart.fill"))
        cartButton.setBadge(with: 2)
        cartButton.position = .right
        cartButton.badgeSize = .extraSmall
        cartButton.tapAction = { [weak self] in
            self?.cartButtonPressed()
        }
        self.navigationItem.rightBarButtonItem  = cartButton
        self.title = "Products"
    }
    
    private func configureConstraint() {
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeTopAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeTrailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeBottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
    
    @objc func cartButtonPressed() {
        let cartVM = CartListVCViewModel()
        let cartVC = CartListVCViewController(viewModel: cartVM, loadXib: false)
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
}
