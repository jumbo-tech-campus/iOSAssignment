//
//  ProductsViewModel.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 16/02/22.
//

import Combine

class ProductsViewModel {
    @MainActor @Published var products: [ProductCellViewModel] = []

    private let repository: ProductsRepositoryType
    private var currentTask: Task<(), Never>?

    init(repository: ProductsRepositoryType = ProductsRepository()) {
        self.repository = repository
    }

    @MainActor
    func productsEvent(action: ProductsControllerAction) {
        switch action {
            case .firstLoad:
                firstLoad()
            case .viewCart:
                print("viewCart")
            case .addToCart(id: let id):
                print("addToCart", id)
            case .removeFromCart(id: let id):
                print("removeFromCart", id)
        }
    }

    private func firstLoad() {

        if let currentTask = currentTask {
            currentTask.cancel()
        }

        currentTask = Task {
            do {
                let products = try await repository.fetchRawProducts() //simulate network call
                let viewModels = products?.products.map { product in
                    ProductCellViewModel(product: product, productsViewModel: self)
                } ?? []
                await MainActor.run { self.products = viewModels }
            } catch {
                print(error)
            }
        }

    }
}
