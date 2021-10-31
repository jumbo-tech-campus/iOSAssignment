//
//  CartCoordinator.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 31/10/21.
//

import UIKit

protocol CartCoordinatorProtocol: Coordinator {
    //TODO: handle presentation actions
}

final class CartCoordinator: CartCoordinatorProtocol {

    // MARK: - Attributes

    private weak var navigationController: UINavigationController?

    // MARK: - Life cycle

    init(presenter: UINavigationController) {
        navigationController = presenter
    }

    // MARK: - Custom methods

    func start() {
        let viewModel = CartViewModel(coordinator: self)
        let viewController = CartViewController(viewModel: viewModel)
        navigationController?.viewControllers = [viewController]
    }
}
