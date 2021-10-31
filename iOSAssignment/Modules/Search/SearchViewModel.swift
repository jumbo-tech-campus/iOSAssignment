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
    var dataUpdated: Dynamic<Void?> { get }

    func loadProducts()
    func addProduct(_ product: Product)
    func removeProduct(_ product: Product)
}

final class SearchViewModel: SearchViewModelProtocol {

    // MARK: - Attributes

    private let coordinator: SearchCoordinatorProtocol?
    private let service: ProductServicesProtocol
    private let cart: CartManagerProtocol
    private var products = [Product]()

    let isLoading = Dynamic<Bool>(false)
    let dataUpdated = Dynamic<Void?>(nil)
    let messageData = Dynamic<MessageData?>(nil)
    var title: String { R.string.localizable.tabBarSearchTitle() }

    // MARK: - Life cycle

    init(coordinator: SearchCoordinatorProtocol? = nil,
         service: ProductServicesProtocol = ProductServices(),
         cart: CartManagerProtocol = CartManager()) {
        self.coordinator = coordinator
        self.service = service
        self.cart = cart
    }

    // MARK: - Custom methods

    func loadProducts() {
        isLoading.value =  true
        service.requestAllProducts { [weak self] response in
            switch response {
                case .success(let result):
                    self?.products = result.products
                    self?.setupCountProducts()
                    self?.sort()
                case .failure(let error, _):
                    self?.messageData.value = .init(category: .error, message: error.message)
            }
            self?.isLoading.value = false
        }
    }

    private func setupCountProducts() {
        products.forEach { $0.countOnCart = cart.countProducts(id: $0.id) }
        dataUpdated.fire()
    }

    private func sort() {
        products.sort(by: { $0.available && !$1.available })
    }

    func addProduct(_ product: Product) {
        cart.addProduct(product)
        setupCountProducts()
    }

    func removeProduct(_ product: Product) {
        cart.removeProduct(product)
        setupCountProducts()
    }
}

// MARK: - SearchViewModel protocol

extension SearchViewModel: SearchViewModelBaseProtocol {

    func viewModel(for index: Int) -> SearchCellViewModelProtocol? {
        guard let product = products[safe: index] else { return nil }
        let cellViewModel = SearchCellViewModel(product: product)
        cellViewModel.delegate = self
        return cellViewModel
    }

    func countItems(in section: Int) -> Int {
        products.count
    }
}

// MARK: - Search content delegate

extension SearchViewModel: SearchCellContentDelegate {

    func addButtonPressed(product: Product) {
        addProduct(product)
    }

    func removeButtonPressed(product: Product) {
        removeProduct(product)
    }
}
