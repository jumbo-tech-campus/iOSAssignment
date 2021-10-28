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
        bindData()
        viewModel.loadProducts()
    }

    // MARK: - Custom methods

    private func setupUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        populateStaticInfo()
        createElements()
    }

    private func populateStaticInfo() {
        title = viewModel.title
    }

    private func bindData() {
        bindStatusLoader()
        bindMessageData()
    }
}

// MARK: - Bind data

private extension SearchViewController {

    func bindStatusLoader() {
        viewModel.isLoading.bind { [weak self] isLoading in
            isLoading ? self?.view.startLoader() : self?.view.stopLoader()
        }
    }

    func bindMessageData() {
        viewModel.messageData.bind { _ in
            //TODO: Handle it
        }
    }
}

// MARK: - Create elements

private extension SearchViewController {

    func createElements() {
        //TODO: Handle it
    }
}
