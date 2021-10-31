//
//  HomeContent.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 30/10/21.
//

import UIKit

final class HomeContent: UIView {

    // MARK: - Attributes

    weak var viewModel: HomeViewModelProtocol?

    // MARK: - Elements

    private let buttonOpenSearch: UIButton = create {
        $0.backgroundColor = .clPrimary
        $0.setTitleColor(.clBlack, for: .normal)
        $0.setTitle(R.string.localizable.homeOpenSearchButton(), for: .normal)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(buttonOpenSearchPressed), for: .touchUpInside)
    }

    // MARK: - Life cycle

    init() {
        super.init(frame: .zero)

        defineSubviews()
        defineSubviewsConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom methods

    private func defineSubviews() {
        backgroundColor = .clSecondary
        addSubview(buttonOpenSearch)
    }

    @objc private func buttonOpenSearchPressed() {
        viewModel?.openSearch()
    }
}

// MARK: - Constraints

extension HomeContent {

    private func defineSubviewsConstraints() {
        buttonOpenSearch.centerInSuperview()
        NSLayoutConstraint.activate([
            buttonOpenSearch.heightAnchor.constraint(equalToConstant: 44),
            buttonOpenSearch.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
