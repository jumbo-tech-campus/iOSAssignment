//
//  SearchViewModel.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

protocol SearchViewModelProtocol {
    func openProductDetail()
}

final class SearchViewModel: SearchViewModelProtocol {

    // MARK: - Attributes

    private let coordinator: SearchCoordinatorProtocol?

    // MARK: - Life cycle

    init(coordinator: SearchCoordinatorProtocol? = nil) {
        self.coordinator = coordinator
    }

    // MARK: - Custom methods

    func openProductDetail() {
        coordinator?.openProductDetail()
    }
}
