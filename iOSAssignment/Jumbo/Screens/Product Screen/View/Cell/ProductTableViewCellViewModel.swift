//
//  ProductTableViewCellViewModel.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//  
//

import Foundation
import RxSwift

class ProductTableViewCellViewModel: BaseTableViewCellViewModel {
    
    // MARK:- Dependency
    
    private weak var imageManager: ImageManagerProtocol?
    
    //MARK:- Input
    private let product: ProductRaw
    
    // MARK- Output
    var id: String { product.id }
    var name: String { product.title }
    var isQuantityHidden: Bool { product.quantity == nil }
    var quantity: String { formatQuantity() }
    var price: String { formatPrice() }
    var unitPrice: String { formatUnitPrice() }
    var productImage = BehaviorSubject<UIImage?>.init(value: nil)

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
        , imageManager: ImageManagerProtocol = ImageManager()){
        self.product = product
        self.imageManager = imageManager
        super.init()
        self.downloadProductImage()
    }
    
    //
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
}
