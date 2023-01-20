//
//  File.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/19/23.
//

import UIKit

class MainTabBarController: UITabBarController, CartManagerDelegate {
    
    var cartTabBarItem: UITabBarItem? {
        return tabBar.items?.first(where: { $0.title == "Cart" })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CartManager.shared.delegate = self
        CartManager.shared.load()
    }
    
    func didUpdateCart() {
        let cartItemCount = CartManager.shared.cart.count
        cartTabBarItem?.badgeValue = cartItemCount > 0 ? "\(cartItemCount)" : nil
    }
}
