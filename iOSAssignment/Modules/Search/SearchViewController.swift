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

    // MARK: - Elements

    private let content = SearchContent()

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

    override func loadView() {
        view = content
    }

    // MARK: - Custom methods

    private func setupUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        populateStaticInfo()
        setupContent()
    }

    private func populateStaticInfo() {
        title = viewModel.title
    }

    private func bindData() {
        bindStatusLoader()
        bindDataUpdated()
        bindMessageData()
    }

    private func setupContent() {
        content.viewModel = viewModel
    }
}

// MARK: - Bind data

private extension SearchViewController {

    func bindStatusLoader() {
        viewModel.isLoading.bind { [weak self] isLoading in
            isLoading ? self?.content.render(with: .loading) : self?.content.render(with: .content)
        }
    }

    func bindDataUpdated() {
        viewModel.dataUpdated.bind { [weak self] _ in
            self?.content.render(with: .update)
        }
    }

    func bindMessageData() {
        viewModel.messageData.bind { [weak self] data in
            guard let data = data else { return }
            self?.content.render(with: .error(message: data))
        }
    }
}
