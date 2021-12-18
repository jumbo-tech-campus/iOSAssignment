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
        backgroundColor = .gray
    }
    
    func setupConstraints() {}
}
