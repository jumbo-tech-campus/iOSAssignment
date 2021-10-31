//
//  ProductCellViewModel.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 28/10/21.
//

protocol ProductCellContentDelegate: AnyObject {
    func addButtonPressed(product: Product)
    func removeButtonPressed(product: Product)
}

protocol ProductCellViewModelProtocol: AnyObject {
    var product: Product { get }
    var delegate: ProductCellContentDelegate? { get }

    func addProduct()
    func removeProduct()
}

final class ProductCellViewModel: ProductCellViewModelProtocol {

    // MARK: - Attributes

    private(set) var product: Product
    weak var delegate: ProductCellContentDelegate?

    // MARK: - Life cycle

    init(product: Product) {
        self.product = product
    }

    func addProduct() {
        delegate?.addButtonPressed(product: product)
    }

    func removeProduct() {
        delegate?.removeButtonPressed(product: product)
    }
}
