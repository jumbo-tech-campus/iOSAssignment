//
//  SearchContent.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 28/10/21.
//

import UIKit

protocol SearchViewModelBaseProtocol: AnyObject {
    func viewModel(for index: Int) -> SearchCellViewModelProtocol?
    func countItems(in section: Int) -> Int
}

final class SearchContent: UIView {

    // MARK: - Attributes

    unowned var viewModel: SearchViewModelBaseProtocol!

    // MARK: - Elements

    private let errorView: UIView = create()
    private let tableView: UITableView = create {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
        $0.backgroundColor = .clSecondary
        $0.separatorStyle = .none
        $0.registerClass(cellType: SearchCell.self)
    }

    // MARK: - Life cycle

    init() {
        super.init(frame: .zero)

        defineSubviews()
        defineSubviewsConstraints()
        setupTableViewProtocols()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom methods

    private func setupTableViewProtocols() {
        tableView.dataSource = self
    }

    private func defineSubviews() {
        backgroundColor = .clSecondary
        addSubview(tableView)
        addSubview(errorView)
    }

    private func reload() {
        UIView.performWithoutAnimation {
            self.tableView.reloadData()
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
}

// MARK: - Constraints

extension SearchContent {

    private func defineSubviewsConstraints() {
        tableView.pinToBounds(of: self)
    }
}

// MARK: - TableView dataSource

extension SearchContent: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countItems(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModelCell = viewModel.viewModel(for: indexPath.row) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(with: SearchCell.self, for: indexPath)
        cell.configure(with: viewModelCell)
        return cell
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
                tableView.isHidden = true
                errorView.isHidden = true
                startLoader()

            case .content:
                stopLoader()
                tableView.isHidden = false
                errorView.isHidden = true
                reload()

            case .error:
                stopLoader()

                //TODO: handle error message

                tableView.isHidden = true
                errorView.isHidden = false
            case .update:
                stopLoader()
                reload()
        }
    }
}
