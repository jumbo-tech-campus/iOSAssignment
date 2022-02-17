//
//  ProductsViewModel+CartViewModelDelegate.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 17/02/22.
//

extension ProductsViewModel: CartViewModelDelegate {

    func cartViewControllerDidDismiss() {
        Task { await MainActor.run { productsEvent(action: .cartDismissed) } }
    }
}
