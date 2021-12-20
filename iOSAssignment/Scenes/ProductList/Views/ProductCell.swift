//
//  ProductCell.swift
//  iOSAssignment
//
//  Created by David Velarde on 19/12/2021.
//

import UIKit

enum ProductCellState {
    case normal
    case interaction
}

class ProductCell: UITableViewCell {
    
    private(set) var state: ProductCellState = .normal
    
    let productView: ProductView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        productView = ProductView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        state = .normal
    }
    
    func updateState(_ state: ProductCellState, animated: Bool) {
        guard self.state != state else { return }
        self.state = state
        productView.updateState(state, animated: animated)
    }
    
    func setupComponents() {
        contentView.addSubviewForAutolayout(productView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            productView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
