//
//  SearchViewModel.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

protocol SearchViewModelProtocol {
    var isLoading: Dynamic<Bool> { get }
    var messageData: Dynamic<MessageData?> { get }
    var title: String { get }
    var countProducts: Int { get }

    func loadProducts()
    func getProduct(from index: Int) -> Product?
    func openProductDetail()
}

final class SearchViewModel: SearchViewModelProtocol {

    // MARK: - Attributes

    private let coordinator: SearchCoordinatorProtocol?
    private let service: ProductServicesProtocol
    private var products = [Product]()

    let isLoading = Dynamic<Bool>(false)
    let messageData = Dynamic<MessageData?>(nil)
    var title: String { R.string.localizable.tabBarSearchTitle() }
    var countProducts: Int { products.count }

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

    func getProduct(from index: Int) -> Product? {
        products[safe: index]
    }

    func openProductDetail() {
        coordinator?.openProductDetail()
    }
}
