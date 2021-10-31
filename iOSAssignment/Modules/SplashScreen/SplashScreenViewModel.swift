//
//  SplashScreenViewModel.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 26/10/21.
//

protocol SplashScreenViewModelProtocol {
    func openMainApp()
}

final class SplashScreenViewModel: SplashScreenViewModelProtocol {

    // MARK: - Attributes

    private let coordinator: SplashScreenCoordinatorProtocol?

    // MARK: - Life cycle

    init(coordinator: SplashScreenCoordinatorProtocol? = nil) {
        self.coordinator = coordinator
    }

    // MARK: - Custom methods

    func openMainApp() {
        coordinator?.openMainApp()
    }
}
