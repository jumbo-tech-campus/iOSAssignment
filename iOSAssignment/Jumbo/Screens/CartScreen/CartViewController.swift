//
//  CartViewController.swift
//  iOSAssignment
//
//  Created by Rodrigo Ruiz Murguia on 17/02/22.
//

import UIKit
import Combine

class CartViewController: UIViewController, ProductDisplayableController {
    let viewModel: CartViewModel
    var dataSource: ProductsDiffableDataSource?
    var cancellables: Set<AnyCancellable> = []
    
    @IBOutlet weak var tableView: UITableView!
    
    init?(coder: NSCoder, viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a viewModel.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViewModel()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        handleRotation()
    }

    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        viewModel.productsEvent(action: .cartDismissed)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
