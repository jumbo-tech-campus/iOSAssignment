//
//  SplashScreenCoordinator.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 26/10/21.
//

import UIKit

protocol SplashScreenCoordinatorDelegate: AnyObject {
    func didFinishSplashScreen()
}

protocol SplashScreenCoordinatorProtocol: Coordinator {
    func openMainApp()
}

final class SplashScreenCoordinator: SplashScreenCoordinatorProtocol {

    // MARK: - Attributes

    private weak var presenter: UIWindow?
    weak var delegate: SplashScreenCoordinatorDelegate?

    // MARK: - Life cycle

    init(presenter: UIWindow) {
        self.presenter = presenter
    }

    // MARK: - Custom methods

    func start() {
        let viewModel = SplashScreenViewModel(coordinator: self)
        let viewController = SplashScreenViewController(viewModel: viewModel)
        presenter?.rootViewController = viewController
        presenter?.makeKeyAndVisible()
    }

    func openMainApp() {
        delegate?.didFinishSplashScreen()
    }
}
