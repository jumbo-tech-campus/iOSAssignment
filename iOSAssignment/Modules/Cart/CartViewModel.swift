//
//  CartViewModel.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 31/10/21.
//

protocol CartViewModelProtocol: CartContentProtocol {
    var messageData: Dynamic<MessageData?> { get }
    var title: String { get }
    var isLoading: Dynamic<Bool> { get }
    var dataUpdated: Dynamic<Void?> { get }

    func loadProducts()
    func addProduct(_ product: Product)
    func removeProduct(_ product: Product)
}

final class CartViewModel: CartViewModelProtocol {

    // MARK: - Attributes

    private let coordinator: CartCoordinatorProtocol?
    private let cart: CartManagerProtocol
    private var products = [Product]()

    let isLoading = Dynamic<Bool>(false)
    let dataUpdated = Dynamic<Void?>(nil)
    let messageData = Dynamic<MessageData?>(nil)
    var title: String { R.string.localizable.cartNavigationTitle() }

    // MARK: - Life cycle

    init(coordinator: CartCoordinatorProtocol? = nil,
         cart: CartManagerProtocol = CartManager()) {
        self.coordinator = coordinator
        self.cart = cart
    }

    // MARK: - Custom methods

    func loadProducts() {
        isLoading.value =  true
        reloadProducts()
        isLoading.value =  false
    }

    private func reloadProducts() {
        products = cart.loadProducts().compactMap {
            $0.product?.countOnCart = $0.count
            return $0.product
        }
    }

    func addProduct(_ product: Product) {
        cart.addProduct(product)
        reloadProducts()
        dataUpdated.fire()
    }

    func removeProduct(_ product: Product) {
        cart.removeProduct(product)
        reloadProducts()
        dataUpdated.fire()
    }

    func countAllItems() -> Int {
        cart.countAll()
    }

    func total() -> Int {
        cart.total()
    }
}

// MARK: - CartViewModel protocol

extension CartViewModel: ProductViewModelProtocol {

    func viewModel(for index: Int) -> ProductCellViewModelProtocol? {
        guard let product = products[safe: index] else { return nil }
        let cellViewModel = ProductCellViewModel(product: product)
        cellViewModel.delegate = self
        return cellViewModel
    }

    func countItems(in section: Int) -> Int {
        products.count
    }
}

// MARK: - ProductCell content delegate

extension CartViewModel: ProductCellContentDelegate {

    func addButtonPressed(product: Product) {
        addProduct(product)
    }

    func removeButtonPressed(product: Product) {
        removeProduct(product)
    }
}
