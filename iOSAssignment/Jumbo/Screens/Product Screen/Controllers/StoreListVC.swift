//
//  ProductsListVCViewController.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//  
//

import UIKit

final class StoreListVC: BaseViewController<StoreListVCViewModel> {
    
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
    
    let cartButton = BadgedButtonItem(with: UIImage.init(systemName: "cart.fill"))
    
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.observeBadgeUpdates()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppearSignal.onNext(())
    }
    
    deinit {
        print("Memory deallocated...")
    }
    
    override func bind() {
        viewModel.presentCartSignal.asObservable()
            .subscribe { [weak self] cartVM in
                let cartVC = CartListVCViewController(viewModel: cartVM, loadXib: false)
                self?.navigationController?.pushViewController(cartVC, animated: true)
            }.disposed(by: disposeBag)
        
        // Update cart badge
        viewModel.updateCartBadgeSignal
            .asObservable()
            .subscribe { [weak self] badgeCount in
                self?.cartButton.setBadge(with: badgeCount)
            }.disposed(by: disposeBag)
    }
    
    func observeBadgeUpdates() {
  
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(contentView)
        contentView.addSubview(tableView)
        configureConstraint()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        cartButton.position = .right
        cartButton.badgeSize = .large
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
        viewModel.presentCartView()
    }
    
}
