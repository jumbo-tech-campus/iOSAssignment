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
    let product: ProductRaw
    let inCartQuantity: Int
    private weak var productDisplayableViewModel: ProductDisplayableViewModel?
    private weak var imageManager: ImageManager?

    var productImage: UIImage? {
        get async {
            await parseImage()
        }
    }

    var id: String { product.id }
    var name: String { product.title }
    var isQuantityHidden: Bool { product.quantity == nil }
    var quantity: String { formatQuantity() }
    var price: String { formatPrice() }
    var unitPrice: String { formatUnitPrice() }
    var cartQuantity: String? { inCartQuantity == 0 ? nil : inCartQuantity.description }

    static let formatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency

        return numberFormatter
    }()

    init(product: ProductRaw,
         productDisplayableViewModel: ProductDisplayableViewModel,
         imageManager: ImageManager,
         inCartQuantity: Int) {
        self.product = product
        self.productDisplayableViewModel = productDisplayableViewModel
        self.imageManager = imageManager
        self.inCartQuantity = inCartQuantity
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
        guard let price = product.prices?.price?.amount,
              let currency = product.prices?.price?.currency else {
            // I don't think price should be nullable
            // but in case it should we could do something like `isQuantityHidden`
            return ""
        }

        let formatter = ProductCellViewModel.formatter
        formatter.currencyCode = currency

        return formatter.string(from: NSNumber(value: price)) ?? ""
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
        guard let productDisplayableViewModel = productDisplayableViewModel else { return }
        let event: ProductsControllerAction

        switch action {
            case .addToCart:
                event = .addToCart(product: product)
            case .removeFromCart:
                event = .removeFromCart(product: product)
        }

        productDisplayableViewModel.productsEvent(action: event)
    }


    // MARK: - Hashable conformance
    static func == (lhs: ProductCellViewModel, rhs: ProductCellViewModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(product.id)
    }
}

