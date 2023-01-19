//
//  File.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/19/23.
//

import UIKit

class TabBarController: UITabBarController, CartManagerDelegate {
    
    var cartTabBarItem: UITabBarItem? {
        return tabBar.items?.first(where: { $0.title == "Cart" })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didUpdateCart()
        CartManager.shared.delegate = self
    }
    
    func didUpdateCart() {
        cartTabBarItem?.badgeValue = "\(CartManager.shared.cart.count)"
    }
}
