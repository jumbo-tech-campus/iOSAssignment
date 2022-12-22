//
//  CartListVCViewController.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 20/12/2022.
//  
//

import UIKit

final class CartListVCViewController: BaseViewController<CartListVCViewModel> {
    
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
    
    deinit {
        print("Memory deallocated...")
    }
    
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
        self.title = "My Cart"
        self.navigationController?.navigationItem.backButtonTitle = nil
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
}
