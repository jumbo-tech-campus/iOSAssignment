//
//  SearchCell.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 28/10/21.
//

import UIKit

final class SearchCell: UITableViewCell {

    // MARK: - Elements

    private var viewModel: SearchCellViewModelProtocol?
    private let content: SearchCellContent = create()

    // MARK: - Life cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        defineSubviews()
        defineSubviewsConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Custom methods

    private func setupUI() {
        selectionStyle = .none
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        content.render(with: .prepareForReuse)
    }

    func configure(with viewModel: SearchCellViewModelProtocol) {

        self.viewModel = viewModel
        content.render(with: .content(viewModel: viewModel))
    }

    private func defineSubviews() {
        contentView.addSubview(content)
    }
}

// MARK: - Constraints

extension SearchCell {

    private func defineSubviewsConstraints() {
        NSLayoutConstraint.activate([
            content.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            content.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            content.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
