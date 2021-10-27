//
//  SearchViewModel.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

protocol SearchViewModelProtocol {
    func loadData()
    func openProductDetail()
}

final class SearchViewModel: SearchViewModelProtocol {

    // MARK: - Attributes

    private let coordinator: SearchCoordinatorProtocol?
    private let service: ProductServicesProtocol

    // MARK: - Life cycle

    init(coordinator: SearchCoordinatorProtocol? = nil,
         service: ProductServicesProtocol = ProductServices()) {
        self.coordinator = coordinator
        self.service = service
    }

    // MARK: - Custom methods

    func loadData() {
        //TODOl: handle it
    }

    func openProductDetail() {
        coordinator?.openProductDetail()
    }
}
