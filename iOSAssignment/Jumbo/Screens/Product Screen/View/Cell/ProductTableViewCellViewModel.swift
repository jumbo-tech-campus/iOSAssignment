//
//  ProductTableViewCellViewModel.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//  
//

import Foundation
import RxSwift

enum ProductTableViewCellActions {
 case addToCart
 case deleteFromCart
}

class ProductTableViewCellViewModel: BaseTableViewCellViewModel {
    
    // MARK:- Dependency
    
    private weak var imageManager: ImageManagerProtocol?
    
    //MARK:- Input
    private let product: ProductRaw
    private var cartQuantity: Int
    
    // MARK- Output
    var events: PublishSubject<ProductListVCActions>
    
    var id: String { product.id }
    var name: String { product.title }
    var isQuantityHidden: Bool { product.quantity == nil  }
    var quantity: String { formatQuantity() }
    var price: String { formatPrice() }
    var unitPrice: String { formatUnitPrice() }
    var productImage = BehaviorSubject<UIImage?>.init(value: nil)
    var quantityInCart: Int { getQuantityInCart() }

    let cellButtonDidTap: PublishSubject<Void> = PublishSubject<()>()
    
    let currencyFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency

        return numberFormatter
    }()
    
    // Assuming values
    let stepperMinCount = 0
    let stepperMaxCount = 10
    
    init(product: ProductRaw
        , cartQuantity: Int
        , events: PublishSubject<ProductListVCActions>
        , imageManager: ImageManagerProtocol = ImageManager()){
        self.product = product
        self.cartQuantity = cartQuantity
        self.events = events
        self.imageManager = imageManager
        super.init()
        self.downloadProductImage()
    }
    
    private func formatQuantity() -> String {
        guard let quantity = product.quantity else { return "" }
        return "Qty: \(quantity)"
    }
    
    private func formatPrice() -> String {
        guard let price = product.prices?.price?.amount,
              let currency = product.prices?.price?.currency else {
            return ""
        }
        
        currencyFormatter.currencyCode = currency
        return currencyFormatter.string(from: NSNumber(value: price)) ?? ""
    }
    
    private func formatUnitPrice()  -> String {
        guard let unitPrice = product.prices?.unitPrice,
              let unit = unitPrice.unit,
              let price = unitPrice.price?.amount else {
            return ""
        }
        return "\(price)/ \(unit)"
    }
    
    private func getQuantityInCart() -> Int {
        return cartQuantity
    }
    
    private func downloadProductImage() {
        guard let primaryView = product.imageInfo?.primaryView,
              let rawImage = primaryView.first,
              let url = URL(string: rawImage.url),
              let downloadImageManager = imageManager else { return  }
        
        downloadImageManager.loadImage(for: url, completion: { [weak self] response in
            switch response {
            case .success(let image):
                self?.productImage.onNext(image)
            case .failure(_): break
                // Handle failure
            }
        })
    }
    
    func productAction(action: ProductTableViewCellActions) {
        switch action {
        case .addToCart: events.onNext( ProductListVCActions.addToCart(product: product))
            cartQuantity += 1
        case .deleteFromCart: events.onNext( ProductListVCActions.deleteFromCart(product: product))
            cartQuantity -= 1
        }
    }
}
