//
//  SearchCellViewModel.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 28/10/21.
//

protocol SearchCellContentDelegate: AnyObject {
    func addButtonPressed(product: Product)
    func removeButtonPressed(product: Product)
}

protocol SearchCellViewModelProtocol: AnyObject {
    var product: Product { get }
    var delegate: SearchCellContentDelegate? { get }

    func addProduct()
    func removeProduct()
}

final class SearchCellViewModel: SearchCellViewModelProtocol {

    // MARK: - Attributes

    private(set) var product: Product
    weak var delegate: SearchCellContentDelegate?

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
