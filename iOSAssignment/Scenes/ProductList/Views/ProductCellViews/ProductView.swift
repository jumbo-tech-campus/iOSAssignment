//
//  ProductView.swift
//  iOSAssignment
//
//  Created by David Velarde on 19/12/2021.
//

import UIKit

class ProductView: UIView {
    
    let productImageView: UIImageView
    let productNameLabel: UILabel
    let productSizeLabel: UILabel
    let productPriceView: PriceView
    let productAddCartButton: AddCartButton
    
    override init(frame: CGRect) {
        
        productImageView = UIImageView()
        productNameLabel = UILabel()
        productSizeLabel = UILabel()
        productPriceView = PriceView()
        productAddCartButton = AddCartButton()
        
        super.init(frame: frame)
        
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        
        productNameLabel.font = .jumboText(withSize: 14)
        productNameLabel.numberOfLines = 0
        
        productSizeLabel.font = .jumboText(withSize: 14)
        productSizeLabel.numberOfLines = 0
        productSizeLabel.textColor = .gray
        
        productImageView.contentMode = .scaleAspectFit
        
        
        addSubviewForAutolayout(productImageView)
        addSubviewForAutolayout(productNameLabel)
        addSubviewForAutolayout(productSizeLabel)
        addSubviewForAutolayout(productPriceView)
        addSubviewForAutolayout(productAddCartButton)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 90),
            productImageView.heightAnchor.constraint(equalToConstant: 90),
            
            productNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            
            productSizeLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 16),
            productSizeLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            productSizeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            productPriceView.leadingAnchor.constraint(equalTo: productNameLabel.trailingAnchor, constant: 16),
            productPriceView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            productPriceView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
        ])
        
    }
}
