//
//  SearchViewController.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

import UIKit

final class SearchViewController: UIViewController {

    // MARK: - Attributes

    private let viewModel: SearchViewModelProtocol

    // MARK: - Life cycle

    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel.loadData()
    }

    // MARK: - Custom methods

    private func setupUI() {
        view.backgroundColor = .white
        configureNavigationBar()
    }
}
