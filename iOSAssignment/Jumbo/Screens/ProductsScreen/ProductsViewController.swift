//
//  ProductsViewController.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 16/02/22.
//

import UIKit
import Combine

enum ProductSection {
    case store
}

private typealias ProductsDiffableDataSource = UITableViewDiffableDataSource<ProductSection, ProductCellViewModel>
private typealias ProductsSnapshot = NSDiffableDataSourceSnapshot<ProductSection, ProductCellViewModel>

class ProductsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var dataSource: ProductsDiffableDataSource?
    private let viewModel = ProductsViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViewModel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.productsEvent(action: .firstLoad)
    }

    private func configureTableView() {
        tableView.register(ProductCellStretch.nib, forCellReuseIdentifier: ProductCellStretch.identifier)
        tableView.register(ProductCellWide.nib, forCellReuseIdentifier: ProductCellWide.identifier)

        dataSource = UITableViewDiffableDataSource(tableView: tableView) { [weak self] tableView, indexPath, viewModel in

            let identifier: String
            let trait = self?.view.window?.traitCollection

            switch (trait?.verticalSizeClass, trait?.horizontalSizeClass) {
                case (.compact, .regular):
                    identifier = ProductCellWide.identifier
                case (.regular, .compact), (_,_):
                    identifier = ProductCellStretch.identifier
            }

            let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ProductCell
            cell?.setUp(viewModel: viewModel)

            return cell
        }
    }

    private func configureViewModel() {
        viewModel.$products.sink { [dataSource] products in

            var snapshot = ProductsSnapshot()
            snapshot.appendSections([.store])
            snapshot.appendItems(products, toSection: .store)

            dataSource?.apply(snapshot)

        }.store(in: &cancellables)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard var snapshot = dataSource?.snapshot() else { return }

        snapshot.reloadSections([.store])
        dataSource?.apply(snapshot)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
