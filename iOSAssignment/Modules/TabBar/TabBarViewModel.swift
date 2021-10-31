//
//  TabBarViewModel.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 31/10/21.
//

protocol TabBarViewModelProtocol: HomeDelegate {
    var badgeValue: String? { get }
}

final class TabBarViewModel: TabBarViewModelProtocol {

    // MARK: - Attributes

    private let coordinator: TabBarCoordinatorProtocol?
    private let cart: CartManagerProtocol

    var badgeValue: String? {
        let countProducts = cart.countAll()
        return countProducts > 0 ? countProducts.description : nil
    }

    // MARK: - Life cycle

    init(coordinator: TabBarCoordinatorProtocol? = nil,
         cart: CartManagerProtocol = CartManager()) {
        self.coordinator = coordinator
        self.cart = cart
    }
}

// MARK: - Home delegate {

extension TabBarViewModel: HomeDelegate {

    func openSearchDidPress() {
        coordinator?.openSearch()
    }
}
