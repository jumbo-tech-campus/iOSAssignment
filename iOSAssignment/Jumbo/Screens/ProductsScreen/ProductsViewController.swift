//
//  ProductsViewController.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 16/02/22.
//

import UIKit
import Combine

enum ProductSection {
    case store
}

class ProductsViewController: UIViewController, ProductDisplayableController, UIAdaptivePresentationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var dataSource: ProductsDiffableDataSource?
    let viewModel = ProductsViewModel()
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViewModel()
        configureSegway()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.productsEvent(action: .reload) 
    }

    private func configureSegway() {
        viewModel.cartViewModelPublisher.sink { [weak self] viewModel in
            guard let self = self,
                  let cartViewController = self.storyboard?
                    .instantiateViewController(identifier: "CartViewController", creator: { coder in
                      CartViewController(coder: coder, viewModel: viewModel)
                  }) else { return }
            cartViewController.presentationController?.delegate = self
            self.present(cartViewController, animated: true, completion: nil)
        }.store(in: &cancellables)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        handleRotation()
    }

    @MainActor
    @IBAction func CartButtonPressed(_ sender: UIBarButtonItem) {
        viewModel.productsEvent(action: .viewCart)
    }

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        viewModel.productsEvent(action: .reload)
    }
}
