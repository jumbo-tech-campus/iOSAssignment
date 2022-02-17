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
         cartManager: CartManager = DiskCartManager()) {
        self.repository = repository
        self.imageManager = imageManager
        self.cartManager = cartManager

        Task { await cartManager.load() }
    }

    @MainActor
    func productsEvent(action: ProductsControllerAction) {
        switch action {
            case .firstLoad:
                firstLoad()
            case .viewCart:
                print("viewCart")
            case .addToCart(let product):
                Task {
                    await cartManager.addToCart(product: product)
                    await cartManager.save()
                    await update(product: product)
                }
            case .removeFromCart(let product):
                Task {
                    await cartManager.removeFromCart(product: product)
                    await cartManager.save()
                    await update(product: product)
                }
        }
    }

    @MainActor
    private func update(product: ProductRaw) async {
        guard let index = products.firstIndex(where: {
            viewModel in viewModel.id == product.id
        }) else { return }
        
        products[index] = ProductCellViewModel(product: product,
                                               productsViewModel: self,
                                               imageManager: imageManager,
                                               inCartQuantity: await cartManager.quantity(for: product))
    }

    private func firstLoad() {

        if let currentTask = currentTask {
            currentTask.cancel()
        }

        currentTask = Task {
            do {

                let products = try await repository.fetchRawProducts()?.products ?? [] //simulate network call
                var buffer: [ProductCellViewModel] = []

                for product in products {
                    let quantity = await cartManager.quantity(for: product)
                    let viewModel = ProductCellViewModel(product: product,
                                                         productsViewModel: self,
                                                         imageManager: imageManager,
                                                         inCartQuantity: quantity)
                    buffer.append(viewModel)
                }

                let viewModels = buffer // need to pass a `let` to `MainActor.run`
                await MainActor.run { self.products = viewModels }
            } catch { // No actual error here because of the "simulate network call" above
                print(error)
            }
        }

    }
}
