//
//  SearchCellViewModel.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 28/10/21.
//

protocol SearchCellViewModelProtocol: AnyObject {
    var product: Product { get }
}

final class SearchCellViewModel: SearchCellViewModelProtocol {

    // MARK: - Attributes

    private(set) var product: Product

    // MARK: - Life cycle

    init(product: Product) {
        self.product = product
    }
}
