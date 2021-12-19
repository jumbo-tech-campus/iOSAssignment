//
//  ProductListView.swift
//  iOSAssignment
//
//  Created by David Velarde on 19/12/2021.
//

import UIKit

class ProductListView: UIView {
    
    let tableView: UITableView
    
    override init(frame: CGRect) {
        tableView = UITableView(frame: .zero)
        super.init(frame: frame)
        
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        
    }
    
    func setupConstraints() {
        
    }
}
