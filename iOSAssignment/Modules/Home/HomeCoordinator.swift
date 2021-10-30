//
//  HomeCoordinator.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 30/10/21.
//

import UIKit

protocol HomeDelegate: AnyObject {
    func openSearchDidPress()
}

protocol HomeCoordinatorProtocol: Coordinator {
    func openSearch()
}

final class HomeCoordinator: HomeCoordinatorProtocol {

    // MARK: - Attributes

    private weak var navigationController: UINavigationController?
    weak var delegate: HomeDelegate?

    // MARK: - Life cycle

    init(presenter: UINavigationController) {
        navigationController = presenter
    }

    // MARK: - Custom methods

    func start() {
        let viewModel = HomeViewModel(coordinator: self)
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController?.viewControllers = [viewController]
    }

    func openSearch() {
        delegate?.openSearchDidPress()
    }
}
