//
//  ProductCellViewModel.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 16/02/22.
//

import UIKit

enum ProductsCellAction {
    case addToCart
    case removeFromCart
}

class ProductCellViewModel: Hashable {

    private let product: ProductRaw

    var productImage: UIImage? {
        get async {
            await parseImage()
        }
    }
    
    var name: String { product.title }
    var isQuantityHidden: Bool { product.quantity == nil }
    var quantity: String { formatQuantity() }
    var price: String { formatPrice() }
    var unitPrice: String { formatUnitPrice() }
    var cartQuantity: String? { (0...1).randomElement() == 0 ? nil : "1" }
    private weak var productsViewModel: ProductsViewModel?
    private weak var imageManager: ImageManager?

    init(product: ProductRaw, productsViewModel: ProductsViewModel, imageManager: ImageManager) {
        self.product = product
        self.productsViewModel = productsViewModel
        self.imageManager = imageManager
    }

    // MARK: - Data processing
    func parseImage() async -> UIImage? {
        guard let primaryView = product.imageInfo?.primaryView,
              let imageDetail = primaryView.first,
              let url = URL(string: imageDetail.url),
              let imageManager = imageManager,
              let data = try? await imageManager.download(url: url) else { // A proper error handling logic is needed
                  return UIImage(systemName: "hexagon.fill")
              }

        return UIImage(data: data)

    }

    func formatPrice() -> String {
        guard let price = product.prices?.price?.amount.description else {
            // I don't think price should be nullable
            // but in case it should we could do something like `isQuantityHidden`
            return ""
        }

        return price
    }

    func formatUnitPrice() -> String {
        guard let unitPrice = product.prices?.unitPrice,
              let unit = unitPrice.unit,
              let price = unitPrice.price?.amount else {
                  // I don't think these should be nullable
                  // but in case they should we could do something like `isQuantityHidden`
                  return ""
              }

        return "\(price)/\(unit)"
    }

    func formatQuantity() -> String {
        guard let quantity = product.quantity else {
            return ""
        }

        return "Inhoud: \(quantity)"
    }

    @MainActor
    func productsEvent(action: ProductsCellAction) {
        guard let productsViewModel = productsViewModel else { return }
        let event: ProductsControllerAction

        switch action {
            case .addToCart:
                event = .addToCart(id: product.id)
            case .removeFromCart:
                event = .removeFromCart(id: product.id)
        }

        productsViewModel.productsEvent(action: event)
    }


    // MARK: - Hashable conformance
    static func == (lhs: ProductCellViewModel, rhs: ProductCellViewModel) -> Bool {
        lhs.product.id == rhs.product.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(product.id)
    }
}

