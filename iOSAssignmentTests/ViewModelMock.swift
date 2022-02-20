//
//  ViewModelMock.swift
//  iOSAssignmentTests
//
//  Created by Rodrigo Ruiz Murguia on 17/02/22.
//

@testable import iOSAssignment
import XCTest

class ViewModelMock: ProductDisplayableViewModel {
    @MainActor @Published var products: [ProductCellViewModel] = []
    var productsPublisher: Published<[ProductCellViewModel]>.Publisher { $products }

    var reportedEvents: [ProductsControllerAction] = []

    func productsEvent(action: ProductsControllerAction) {
        reportedEvents.append(action)
    }
}

