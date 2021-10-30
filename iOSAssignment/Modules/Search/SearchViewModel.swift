//
//  SearchViewModel.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

protocol SearchViewModelProtocol: SearchViewModelBaseProtocol {
    var messageData: Dynamic<MessageData?> { get }
    var title: String { get }
    var isLoading: Dynamic<Bool> { get }

    func loadProducts()
}

final class SearchViewModel: SearchViewModelProtocol {

    // MARK: - Attributes

    private let coordinator: SearchCoordinatorProtocol?
    private let service: ProductServicesProtocol
    private var products = [Product]()

    let isLoading = Dynamic<Bool>(false)
    let messageData = Dynamic<MessageData?>(nil)
    var title: String { R.string.localizable.tabBarSearchTitle() }

    // MARK: - Life cycle

    init(coordinator: SearchCoordinatorProtocol? = nil,
         service: ProductServicesProtocol = ProductServices()) {
        self.coordinator = coordinator
        self.service = service
    }

    // MARK: - Custom methods

    func loadProducts() {
        isLoading.value =  true
        service.requestAllProducts { [weak self] response in
            switch response {
                case .success(let result):
                    self?.products = result.products
                case .failure(let error, _):
                    self?.messageData.value = .init(category: .error, message: error.message)
            }
            self?.isLoading.value = false
        }
    }
}

// MARK: - SearchViewModel protocol

extension SearchViewModel: SearchViewModelBaseProtocol {

    func viewModel(for index: Int) -> SearchCellViewModelProtocol? {
        guard let product = products[safe: index] else { return nil }
        return SearchCellViewModel(product: product)
    }

    func countItems(in section: Int) -> Int {
        products.count
    }
}
