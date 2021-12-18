//
//  WelcomeView.swift
//  iOSAssignment
//
//  Created by David Velarde on 18/12/2021.
//

import UIKit

class WelcomeView: UIView {
    
    let goToProductListButton: UIButton
    
    override init(frame: CGRect) {
        
        goToProductListButton = UIButton(type: .custom)
        
        super.init(frame: frame)
        
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        backgroundColor = .white
        
        goToProductListButton.setTitle("Go to Product List", for: .normal)
        goToProductListButton.backgroundColor = .jumboYellow
        
        goToProductListButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        goToProductListButton.layer.cornerRadius = 8
        
        addSubviewForAutolayout(goToProductListButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            goToProductListButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            goToProductListButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            goToProductListButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            goToProductListButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
        ])
    }
}
