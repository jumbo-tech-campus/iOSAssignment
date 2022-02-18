//
//  CartViewModel.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 17/02/22.
//

import Combine

protocol CartViewModelDelegate: AnyObject {
    func cartViewControllerDidDismiss()
}

class CartViewModel: ProductDisplayableViewModel {

    @MainActor @Published var products: [ProductCellViewModel] = []
    var productsPublisher: Published<[ProductCellViewModel]>.Publisher { $products }
    weak var delegate: CartViewModelDelegate?
    
    private let imageManager: ImageManager
    private let cartManager: CartManager

    @MainActor
    init(products: [ProductCellViewModel], imageManager: ImageManager, cartManager: CartManager) {
        self.products = []
        self.imageManager = imageManager
        self.cartManager = cartManager

        self.products = products.map({ viewModel in
            ProductCellViewModel(product: viewModel.product,
                                 productDisplayableViewModel: self,
                                 imageManager: imageManager,
                                 inCartQuantity: viewModel.inCartQuantity)
        })
    }

    @MainActor
    init(products: [ProductRaw], imageManager: ImageManager, cartManager: CartManager) async {
        self.products = []
        self.imageManager = imageManager
        self.cartManager = cartManager

        var buffer: [ProductCellViewModel] = []

        for product in products {
            let quantity = await cartManager.quantity(for: product)
            let viewModel = ProductCellViewModel(product: product,
                                                 productDisplayableViewModel: self,
                                                 imageManager: imageManager,
                                                 inCartQuantity: quantity)
            buffer.append(viewModel)
        }

        self.products = buffer
    }

    @MainActor
    func productsEvent(action: ProductsControllerAction) {
        switch action {
            case .reload,   // Not needed, we passed all the data on the constructor
                 .viewCart: // Not needed, already on cart
                print("not needed")
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
            case .cartDismissed:
                delegate?.cartViewControllerDidDismiss()
        }
    }

    @MainActor
    private func update(product: ProductRaw) async {
        guard let index = products.firstIndex(where: {
            viewModel in viewModel.id == product.id
        }) else { return }

        let quantity = await cartManager.quantity(for: product)

        if quantity > 0 {
            products[index] = ProductCellViewModel(product: product,
                                                   productDisplayableViewModel: self,
                                                   imageManager: imageManager,
                                                   inCartQuantity: quantity)
        } else {
            products.remove(at: index)
        }

    }
}
