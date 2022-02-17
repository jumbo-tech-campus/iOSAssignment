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
    private let imageManager: ImageManager
    private let cartManager: CartManager
    private var currentTask: Task<(), Never>?

    init(repository: ProductsRepositoryType = ProductsRepository(),
         imageManager: ImageManager = ImageManager(),
         cartManager: CartManager = MemoryCartManager()) {
        self.repository = repository
        self.imageManager = imageManager
        self.cartManager = cartManager
    }

    @MainActor
    func productsEvent(action: ProductsControllerAction) {
        switch action {
            case .firstLoad:
                firstLoad()
            case .viewCart:
                print("viewCart")
            case .addToCart(let product):
                cartManager.addToCart(product: product)
                update(product: product)
            case .removeFromCart(let product):
                cartManager.removeFromCart(product: product)
                update(product: product)
        }
    }

    @MainActor
    private func update(product: ProductRaw) {
        guard let index = products.firstIndex(where: {
            viewModel in viewModel.id == product.id
        }) else { return }
        
        products[index] = ProductCellViewModel(product: product,
                                               productsViewModel: self,
                                               imageManager: imageManager,
                                               inCartQuantity: cartManager.quantity(for: product))
    }

    private func firstLoad() {

        if let currentTask = currentTask {
            currentTask.cancel()
        }

        currentTask = Task {
            do {
                let products = try await repository.fetchRawProducts() //simulate network call
                let viewModels = products?.products.map { product in

                    ProductCellViewModel(product: product,
                                         productsViewModel: self,
                                         imageManager: imageManager,
                                         inCartQuantity: cartManager.quantity(for: product))

                } ?? []
                await MainActor.run { self.products = viewModels }
            } catch {
                print(error)
            }
        }

    }
}
