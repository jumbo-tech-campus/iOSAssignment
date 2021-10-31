//
//  ListProductsComponent.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 31/10/21.
//

import UIKit

protocol ProductViewModelProtocol: AnyObject {
    func viewModel(for index: Int) -> ProductCellViewModelProtocol?
    func countItems(in section: Int) -> Int
}

final class ListProductsComponent: UIView {

    // MARK: - Attributes

    weak var viewModel: ProductViewModelProtocol?

    // MARK: - Elements

    private let tableView: UITableView = create {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
        $0.backgroundColor = .clSecondary
        $0.separatorStyle = .none
        $0.allowsSelection = false
        $0.registerClass(cellType: ProductCell.self)
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

    // MARK: - Custom methods

    private func setupProtocols() {
        tableView.dataSource = self
    }

    private func defineSubviews() {
        backgroundColor = .clSecondary
        addView(tableView)
    }

    private func reload() {
        tableView.reloadData()
    }
}

// MARK: - TableView dataSource

extension ListProductsComponent: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.countItems(in: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModelCell = viewModel?.viewModel(for: indexPath.row) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(with: ProductCell.self, for: indexPath)
        cell.configure(with: viewModelCell)
        return cell
    }
}

// MARK: - Constraints

extension ListProductsComponent {

    private func defineSubviewsConstraints() {
        setupTableConstraints()
    }

    private func setupTableConstraints() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - Component

extension ListProductsComponent: Component {

    enum Configuration {
        case loading, content, error(message: MessageData), update
    }

    func render(with configuration: Configuration) {
        switch configuration {
            case .loading:
                tableView.isHidden = true
                startLoader()

            case .content:
                stopLoader()
                tableView.isHidden = false
                reload()

            case .error:
                stopLoader()

                //TODO: handle error message

                tableView.isHidden = true
            case .update:
                stopLoader()
                reload()
        }
    }
}
