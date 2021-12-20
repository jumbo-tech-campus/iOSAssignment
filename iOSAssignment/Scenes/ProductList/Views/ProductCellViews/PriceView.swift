//
//  PriceView.swift
//  iOSAssignment
//
//  Created by David Velarde on 19/12/2021.
//

import UIKit

class PriceView: UIView {
    
    let integerLabel: UILabel
    let fractionLabel: UILabel
    let priceSpecLabel: UILabel
    
    override init(frame: CGRect) {
        
        integerLabel = UILabel()
        fractionLabel = UILabel()
        priceSpecLabel = UILabel()
        
        super.init(frame: frame)
        
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        
        integerLabel.font = .jumboNumbersBlack(withSize: 20)
        fractionLabel.font = .jumboNumbersBlack(withSize: 14)
        priceSpecLabel.font = .jumboText(withSize: 14)
        
        priceSpecLabel.textAlignment = .right
        priceSpecLabel.textColor = .gray
        
        addSubviewForAutolayout(integerLabel)
        addSubviewForAutolayout(fractionLabel)
        addSubviewForAutolayout(priceSpecLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            fractionLabel.topAnchor.constraint(equalTo: topAnchor),
            fractionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            integerLabel.trailingAnchor.constraint(equalTo: fractionLabel.leadingAnchor, constant: -4),
            integerLabel.topAnchor.constraint(equalTo: topAnchor),
            integerLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            
            priceSpecLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            priceSpecLabel.topAnchor.constraint(equalTo: integerLabel.bottomAnchor, constant: 4),
            priceSpecLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceSpecLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
