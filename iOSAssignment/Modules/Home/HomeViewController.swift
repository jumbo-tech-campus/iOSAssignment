//
//  HomeViewController.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 30/10/21.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Attributes

    private let viewModel: HomeViewModelProtocol

    // MARK: - Elements

    private let content = HomeContent()

    // MARK: - Life cycle

    init(viewModel: HomeViewModelProtocol) {
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

    private func setupContent() {
        content.viewModel = viewModel
    }
}
