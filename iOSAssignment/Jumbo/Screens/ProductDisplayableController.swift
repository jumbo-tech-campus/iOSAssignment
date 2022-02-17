//
//  ProductDisplayableController.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 17/02/22.
//

import UIKit
import Combine

protocol ProductDisplayableController: UIViewController {
    typealias ProductsDiffableDataSource = UITableViewDiffableDataSource<ProductSection, ProductCellViewModel>
    typealias ProductsSnapshot = NSDiffableDataSourceSnapshot<ProductSection, ProductCellViewModel>
    associatedtype ViewModel: ProductDisplayableViewModel

    var viewModel: ViewModel { get }
    var tableView: UITableView! { get }
    var dataSource: ProductsDiffableDataSource? { get set }
    var cancellables: Set<AnyCancellable> { get set }
}

extension ProductDisplayableController {
    func configureTableView() {
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

    @MainActor
    func configureViewModel() {
        viewModel.productsPublisher.sink { [dataSource] products in

            var snapshot = ProductsSnapshot()
            snapshot.appendSections([.store])
            snapshot.appendItems(products, toSection: .store)

            dataSource?.apply(snapshot, animatingDifferences: false)

        }.store(in: &cancellables)
    }

    func handleRotation() {
        guard var snapshot = dataSource?.snapshot() else { return }

        snapshot.reloadSections([.store])
        dataSource?.apply(snapshot)
    }
}
