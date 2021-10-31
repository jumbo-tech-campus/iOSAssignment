//
//  SearchContent.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 28/10/21.
//

import UIKit

protocol SearchViewModelBaseProtocol: ProductViewModelProtocol {
    func search(text: String)
}

final class SearchContent: UIView {

    // MARK: - Attributes

    weak var viewModel: SearchViewModelBaseProtocol? {
        didSet {
            listProductsComponent.viewModel = viewModel
        }
    }

    // MARK: - Elements

    private let errorView: UIView = create()
    private let listProductsComponent: ListProductsComponent = create()
    private let searchBar: UISearchBar = create {
        $0.searchBarStyle = .minimal
    }
    private let labelCountProducts: UILabel = create {
        $0.font = .subDetail
        $0.textAlignment = .left
    }

    // MARK: - Life cycle

    init() {
        super.init(frame: .zero)

        defineSubviews()
        defineSubviewsConstraints()
        setupProtocols()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        endEditing(true)
    }

    // MARK: - Custom methods

    private func setupProtocols() {
        searchBar.delegate = self
    }

    private func defineSubviews() {
        backgroundColor = .clSecondary

        addView(labelCountProducts)
        addView(searchBar)
        addView(listProductsComponent)
        addView(errorView)
    }

    private func reload() {
        updateCounters()
        listProductsComponent.render(with: .update)
    }

    private func updateCounters() {
        let count = viewModel?.countItems(in: 0) ?? 0
        labelCountProducts.text = "\(count.description) " + R.string.localizable.titleProducts()
    }
}

// MARK: - Constraints

extension SearchContent {

    private func defineSubviewsConstraints() {
        setupSearchBarConstraints()
        setupCountProductConstraints()
        setupListProductsConstraints()
    }

    private func setupSearchBarConstraints() {
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            searchBar.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        ])
    }

    private func setupCountProductConstraints() {
        NSLayoutConstraint.activate([
            labelCountProducts.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            labelCountProducts.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8)
        ])
    }

    private func setupListProductsConstraints() {
        NSLayoutConstraint.activate([
            listProductsComponent.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            listProductsComponent.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            listProductsComponent.topAnchor.constraint(equalTo: labelCountProducts.bottomAnchor, constant: 8),
            listProductsComponent.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
}

extension SearchContent: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.search(text: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - Component

extension SearchContent: Component {

    enum Configuration {
        case loading, content, error(message: MessageData), update
    }

    func render(with configuration: Configuration) {
        switch configuration {
            case .loading:
                listProductsComponent.isHidden = true
                errorView.isHidden = true
                startLoader()

            case .content:
                stopLoader()
                listProductsComponent.isHidden = false
                errorView.isHidden = true
                reload()

            case .error:
                stopLoader()

                //TODO: handle error message

                listProductsComponent.isHidden = true
                errorView.isHidden = false
            case .update:
                stopLoader()
                reload()
        }
    }
}
