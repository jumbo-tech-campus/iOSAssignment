//
//  CartContent.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 31/10/21.
//

import UIKit

protocol CartContentProtocol: ProductViewModelProtocol {
    func countAllItems() -> Int
    func total() -> Int
}

final class CartContent: UIView {

    // MARK: - Attributes

    weak var viewModel: CartContentProtocol? {
        didSet {
            listProductsComponent.viewModel = viewModel
        }
    }

    // MARK: - Elements

    private let errorView: UIView = create()
    private let noDataView: UIView = create()
    private let listProductsComponent: ListProductsComponent = create()
    private let summaryView: UIView = create {
        $0.backgroundColor = .clSecondary
        $0.addShadow()
    }
    private let titleSummaryLabel: UILabel = create {
        $0.font = .title
        $0.text = R.string.localizable.cartSummaryTitle()
        $0.textAlignment = .center
    }
    private let titleCountLabel: UILabel = create {
        $0.font = .subDetail
        $0.text = R.string.localizable.cartSummaryCountProductsTitle()
        $0.textAlignment = .left
    }
    private let titleTotalLabel: UILabel = create {
        $0.font = .subDetail
        $0.text = R.string.localizable.cartSummaryTotalTitle()
        $0.textAlignment = .left
    }
    private let infoCountLabel: UILabel = create {
        $0.font = .detail
        $0.textAlignment = .right
    }
    private let infoTotalLabel: UILabel = create {
        $0.font = .detail
        $0.textAlignment = .right
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        endEditing(true)
    }

    // MARK: - Custom methods

    private func defineSubviews() {
        backgroundColor = .clSecondary

        summaryView
            .addView(titleSummaryLabel)
            .addView(titleCountLabel)
            .addView(titleTotalLabel)
            .addView(infoCountLabel)
            .addView(infoTotalLabel)
        addView(summaryView)
        addView(listProductsComponent)
        addView(errorView)
    }

    private func reload() {
        listProductsComponent.render(with: .update)
        checkNoData()
        populateSummary()
    }

    private func checkNoData() {
        if viewModel?.countItems(in: 0) == 0 {
            //TODO: handle no data
        }
    }

    private func populateSummary() {
        let count = viewModel?.countAllItems()
        infoCountLabel.text = count?.description

        let total = viewModel?.total()
        infoTotalLabel.text = total?.toCurrency(symbol: .euro)
    }
}

// MARK: - Constraints

extension CartContent {

    private func defineSubviewsConstraints() {
        setupSummaryConstraints()
        setupSummaryTitleConstraints()
        setupListProductsConstraints()
        setupTitleCountConstraints()
        setupTitleTotalConstraints()
        setupInfoCountConstraints()
        setupInfoTotalConstraints()
    }

    private func setupSummaryConstraints() {
        NSLayoutConstraint.activate([
            summaryView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 24),
            summaryView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -24),
            summaryView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            summaryView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupListProductsConstraints() {
        NSLayoutConstraint.activate([
            listProductsComponent.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            listProductsComponent.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            listProductsComponent.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 8),
            listProductsComponent.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
        ])
    }

    private func setupSummaryTitleConstraints() {
        NSLayoutConstraint.activate([
            titleSummaryLabel.leftAnchor.constraint(equalTo: summaryView.leftAnchor, constant: 4),
            titleSummaryLabel.rightAnchor.constraint(equalTo: summaryView.rightAnchor, constant: -4),
            titleSummaryLabel.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: 2)
        ])
    }

    private func setupTitleCountConstraints() {
        NSLayoutConstraint.activate([
            titleCountLabel.leftAnchor.constraint(equalTo: summaryView.leftAnchor, constant: 4),
            titleCountLabel.topAnchor.constraint(equalTo: titleSummaryLabel.bottomAnchor, constant: 2)
        ])
    }

    private func setupTitleTotalConstraints() {
        NSLayoutConstraint.activate([
            titleTotalLabel.leftAnchor.constraint(equalTo: summaryView.leftAnchor, constant: 4),
            titleTotalLabel.topAnchor.constraint(equalTo: titleCountLabel.bottomAnchor, constant: 2)
        ])
    }

    private func setupInfoCountConstraints() {
        NSLayoutConstraint.activate([
            infoCountLabel.leftAnchor.constraint(equalTo: titleCountLabel.rightAnchor, constant: 4),
            infoCountLabel.rightAnchor.constraint(equalTo: summaryView.rightAnchor, constant: -4),
            infoCountLabel.topAnchor.constraint(equalTo: titleSummaryLabel.bottomAnchor, constant: 2)
        ])
    }

    private func setupInfoTotalConstraints() {
        NSLayoutConstraint.activate([
            infoTotalLabel.leftAnchor.constraint(equalTo: titleTotalLabel.rightAnchor, constant: 4),
            infoTotalLabel.rightAnchor.constraint(equalTo: summaryView.rightAnchor, constant: -4),
            infoTotalLabel.topAnchor.constraint(equalTo: infoCountLabel.bottomAnchor, constant: 2)
        ])
    }
}

// MARK: - Component

extension CartContent: Component {

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
                //TODO: handle error message
                stopLoader()

                listProductsComponent.isHidden = true
                errorView.isHidden = false
            case .update:
                listProductsComponent.isHidden = false
                stopLoader()
                reload()
        }
    }
}
