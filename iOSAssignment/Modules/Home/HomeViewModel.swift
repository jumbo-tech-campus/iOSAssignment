//
//  HomeViewModel.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 30/10/21.
//

protocol HomeViewModelProtocol: AnyObject {
    var title: String { get }
    
    func openSearch()
}

final class HomeViewModel: HomeViewModelProtocol {

    // MARK: - Attributes

    private let coordinator: HomeCoordinatorProtocol?
    var title: String { R.string.localizable.homeNavigationTitle() }

    // MARK: - Life cycle

    init(coordinator: HomeCoordinatorProtocol? = nil) {
        self.coordinator = coordinator
    }

    // MARK: - Custom methods

    func openSearch() {
        coordinator?.openSearch()
    }
}
