//
//  ProductsViewModel.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 16/02/22.
//

import Combine

class ProductsViewModel: ProductDisplayableViewModel {
    @MainActor @Published var products: [ProductCellViewModel] = []
    @MainActor let cartViewModelPublisher = PassthroughSubject<CartViewModel, Never>()

    var productsPublisher: Published<[ProductCellViewModel]>.Publisher { $products }
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
            case .reload, .cartDismissed:
                reload()
            case .viewCart:
                let products = products.filter { viewModel in viewModel.cartQuantity != nil }

                let cartViewModel = CartViewModel(products: products, imageManager: imageManager, cartManager: cartManager)
                cartViewModel.delegate = self
                cartViewModelPublisher.send(cartViewModel)
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
                                               productDisplayableViewModel: self,
                                               imageManager: imageManager,
                                               inCartQuantity: await cartManager.quantity(for: product))
    }

    private func reload() {

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
                                                         productDisplayableViewModel: self,
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
