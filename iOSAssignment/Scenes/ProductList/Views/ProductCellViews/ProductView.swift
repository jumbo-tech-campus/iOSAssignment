//
//  ProductView.swift
//  iOSAssignment
//
//  Created by David Velarde on 19/12/2021.
//

import UIKit

class ProductView: UIView {
    
    let containerView: UIView
    let productImageView: UIImageView
    let productNameLabel: UILabel
    let productSizeLabel: UILabel
    let productPriceView: PriceView
    let productAddCartButton: AddCartButton
    let shadowView: UIView

    override init(frame: CGRect) {
        
        containerView = UIView()
        productImageView = UIImageView()
        productNameLabel = UILabel()
        productSizeLabel = UILabel()
        productPriceView = PriceView()
        productAddCartButton = AddCartButton()
        shadowView = UIView()
        
        super.init(frame: frame)
        
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateState(_ state: ProductCellState, animated: Bool = false) {
        switch state {
        case .normal:
            if animated {
                UIView.animate(withDuration: 0.1) { [weak self] in
                    self?.shadowView.alpha = 0
                }
            } else {
                shadowView.alpha = 0
            }
        case .interaction:
            if animated {
                UIView.animate(withDuration: 0.1) { [weak self] in
                    self?.shadowView.alpha = 1
                }
            } else {
                shadowView.alpha = 1
            }
        }
        
        productAddCartButton.updateState(state, animated: animated)
    }
    
    func setupComponents() {
        
        productNameLabel.font = .jumboText(withSize: 14)
        productNameLabel.numberOfLines = 0
        productNameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        productSizeLabel.font = .jumboText(withSize: 14)
        productSizeLabel.numberOfLines = 0
        productSizeLabel.textColor = .gray
        
        productImageView.contentMode = .scaleAspectFit
        
        shadowView.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        shadowView.alpha = 0
        
        addSubviewForAutolayout(containerView)
        containerView.addSubviewForAutolayout(productImageView)
        containerView.addSubviewForAutolayout(productNameLabel)
        containerView.addSubviewForAutolayout(productSizeLabel)
        containerView.addSubviewForAutolayout(productPriceView)
        addSubviewForAutolayout(shadowView)
        addSubviewForAutolayout(productAddCartButton)
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            productImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            productImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            productImageView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 90),
            productImageView.heightAnchor.constraint(equalToConstant: 90),
            
            productNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            
            productSizeLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 8),
            productSizeLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            productSizeLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16),
            
            productPriceView.leadingAnchor.constraint(equalTo: productNameLabel.trailingAnchor, constant: 16),
            productPriceView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            productPriceView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            productPriceView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16),
            
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            productAddCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            productAddCartButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            productAddCartButton.heightAnchor.constraint(equalToConstant: 24),
            productAddCartButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
        
    }
}
