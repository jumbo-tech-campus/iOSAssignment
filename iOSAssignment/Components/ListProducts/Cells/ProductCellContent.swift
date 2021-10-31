//
//  ProductCellContent.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 28/10/21.
//

import UIKit

final class ProductCellContent: UIView {

    // MARK: - Attributes

    private weak var viewModel: ProductCellViewModelProtocol?

    // MARK: - Elements

    private let priceContentView: UIView = create()
    private let buttonsContentView: UIView = create()
    private let countOnCartLabel: UILabel = create {
        $0.font = .title
        $0.textColor = .clPrimary
    }
    private let descriptionLabel: UILabel = create {
        $0.numberOfLines = 2
        $0.font = .detail
    }
    private let subDescriptionLabel: UILabel = create {
        $0.numberOfLines = 1
        $0.textColor = .clGray
    }
    private let amountLabel: UILabel = create {
        $0.textAlignment = .center
        $0.font = .title
    }
    private let infoAmountLabel: UILabel = create {
        $0.textAlignment = .center
        $0.textColor = .clGray
    }
    private let productImageView: UIImageView = create {
        $0.contentMode = .scaleAspectFit
    }
    private let addCartButton: UIButton = create {
        $0.setImage(R.image.iconPlus(), for: .normal)
        $0.backgroundColor = .clSecondary
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = false
        $0.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        $0.addShadow()
    }
    private let removeCartButton: UIButton = create {
        $0.setImage(R.image.iconMinus(), for: .normal)
        $0.backgroundColor = .clSecondary
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = false
        $0.addTarget(self, action: #selector(removeButtonPressed), for: .touchUpInside)
        $0.addShadow()
    }

    // MARK: - Life cycle

    init() {
        super.init(frame: .zero)

        setupUI()
        defineSubviews()
        defineSubviewsConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Custom methods

    private func defineSubviews() {
        addView(productImageView)
        addView(descriptionLabel)
        addView(subDescriptionLabel)
        buttonsContentView
            .addView(addCartButton)
            .addView(countOnCartLabel)
            .addView(removeCartButton)
        addView(buttonsContentView)
        priceContentView
            .addView(amountLabel)
            .addView(infoAmountLabel)
        addView(priceContentView)
    }

    private func setupUI() {
        backgroundColor = .clBeige
        layer.cornerRadius = 8
        addShadow()
    }

    // MARK: - Actions

    @objc private func addButtonPressed() {
        viewModel?.addProduct()
    }

    @objc private func removeButtonPressed() {
        viewModel?.removeProduct()
    }
}

// MARK: - Component

extension ProductCellContent: Component {

    enum Configuration {
        case prepareForReuse, content(viewModel: ProductCellViewModelProtocol)
    }

    func render(with configuration: Configuration) {

        switch configuration {
            case .content(let viewModel):
                self.viewModel = viewModel
                setupComponent()

            case .prepareForReuse:
                productImageView.image = nil
        }
    }

    private func setupComponent() {
        guard let product = viewModel?.product else { return }

        //Check and disable product when unavailable
        alpha = product.available ? 1.0 : 0.3
        isUserInteractionEnabled = product.available

        //Setup price
        let currencyPrice = product.prices?.price?.currency ?? ""
        amountLabel.text = product.prices?.price?.amount.toCurrency(symbol: .init(value: currencyPrice))

        //Setup unit price
        let unitPrice = product.prices?.unitPrice
        let unitPriceAmount = unitPrice?.price?.amount.toCurrency() ?? ""
        let unitPriceUnit = unitPrice?.unit ?? ""
        infoAmountLabel.text = "\(unitPriceAmount)/\(unitPriceUnit)"

        //Download product image
        let urlImage = product.imageInfo?.primaryView?.first?.url ?? ""
        productImageView.addImage(path: urlImage)

        descriptionLabel.text = product.title
        subDescriptionLabel.text = product.quantity

        let countOnCart = product.countOnCart ?? 0
        removeCartButton.isHidden = countOnCart == 0
        countOnCartLabel.text = countOnCart > 0 ? countOnCart.description : ""
    }
}

// MARK: - Constraints

extension ProductCellContent {

    private func defineSubviewsConstraints() {
        setupImageConstraints()
        setupButtonsContent()
        setupAddButtonConstraints()
        setupCountCartConstraints()
        setupRemoveButtonConstraints()
        setupPriceContentConstraints()
        setupAmountConstraints()
        setupInfoAmountConstraints()
        setupDescriptionConstraints()
        setupSubDescriptionConstraints()
    }

    private func setupImageConstraints() {
        NSLayoutConstraint.activate([
            productImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            productImageView.heightAnchor.constraint(equalToConstant: 48),
            productImageView.widthAnchor.constraint(equalToConstant: 48),
            productImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupButtonsContent() {
        NSLayoutConstraint.activate([
            buttonsContentView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            buttonsContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            buttonsContentView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            buttonsContentView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupAddButtonConstraints() {
        NSLayoutConstraint.activate([
            addCartButton.topAnchor.constraint(equalTo: buttonsContentView.topAnchor),
            addCartButton.centerXAnchor.constraint(equalTo: buttonsContentView.centerXAnchor),
            addCartButton.heightAnchor.constraint(equalToConstant: 24),
            addCartButton.widthAnchor.constraint(equalToConstant: 24),
        ])
    }

    private func setupCountCartConstraints() {
        NSLayoutConstraint.activate([
            countOnCartLabel.topAnchor.constraint(greaterThanOrEqualTo: addCartButton.bottomAnchor, constant: 4),
            countOnCartLabel.centerXAnchor.constraint(equalTo: buttonsContentView.centerXAnchor),
            countOnCartLabel.centerYAnchor.constraint(equalTo: buttonsContentView.centerYAnchor)
        ])
    }

    private func setupRemoveButtonConstraints() {
        NSLayoutConstraint.activate([
            removeCartButton.topAnchor.constraint(greaterThanOrEqualTo: countOnCartLabel.bottomAnchor, constant: 4),
            removeCartButton.centerXAnchor.constraint(equalTo: buttonsContentView.centerXAnchor),
            removeCartButton.heightAnchor.constraint(equalToConstant: 24),
            removeCartButton.widthAnchor.constraint(equalToConstant: 24),
            removeCartButton.bottomAnchor.constraint(equalTo: buttonsContentView.bottomAnchor)
        ])
    }

    private func setupPriceContentConstraints() {
        NSLayoutConstraint.activate([
            priceContentView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            priceContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            priceContentView.rightAnchor.constraint(equalTo: buttonsContentView.leftAnchor, constant: -8),
            priceContentView.widthAnchor.constraint(equalToConstant: 70)
        ])
    }

    private func setupAmountConstraints() {
        NSLayoutConstraint.activate([
            amountLabel.leftAnchor.constraint(equalTo: priceContentView.leftAnchor),
            amountLabel.topAnchor.constraint(equalTo: priceContentView.topAnchor),
            amountLabel.rightAnchor.constraint(equalTo: priceContentView.rightAnchor)
        ])
    }

    private func setupInfoAmountConstraints() {
        NSLayoutConstraint.activate([
            infoAmountLabel.leftAnchor.constraint(equalTo: priceContentView.leftAnchor),
            infoAmountLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 2),
            infoAmountLabel.rightAnchor.constraint(equalTo: priceContentView.rightAnchor),
            infoAmountLabel.bottomAnchor.constraint(lessThanOrEqualTo: priceContentView.bottomAnchor)
        ])
    }

    private func setupDescriptionConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 8),
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            descriptionLabel.rightAnchor.constraint(lessThanOrEqualTo: priceContentView.leftAnchor, constant: -8)
        ])
    }

    private func setupSubDescriptionConstraints() {
        NSLayoutConstraint.activate([
            subDescriptionLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 8),
            subDescriptionLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 2),
            subDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8),
            subDescriptionLabel.rightAnchor.constraint(lessThanOrEqualTo: priceContentView.leftAnchor, constant: -8)
        ])
    }
}
