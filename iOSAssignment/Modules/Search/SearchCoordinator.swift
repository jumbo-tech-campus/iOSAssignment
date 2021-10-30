//
//  SearchCoordinator.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

import UIKit

protocol SearchCoordinatorProtocol: Coordinator {
    //TODO: handle presentation actions
}

final class SearchCoordinator: SearchCoordinatorProtocol {

    // MARK: - Attributes

    private weak var navigationController: UINavigationController?

    // MARK: - Life cycle

    init(presenter: UINavigationController) {
        navigationController = presenter
    }

    // MARK: - Custom methods

    func start() {
        let viewModel = SearchViewModel(coordinator: self)
        let viewController = SearchViewController(viewModel: viewModel)
        navigationController?.viewControllers = [viewController]
    }
}
