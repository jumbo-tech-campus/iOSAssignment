//
//  File.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/19/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var cartTabBarItem: UITabBarItem? {
        return tabBar.items?.first(where: { $0.title == "Cart" })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CartManager.shared.cart.addObserver { [weak self] cart in
            self?.cartTabBarItem?.badgeValue = cart.count > 0 ? "\(cart.count)" : nil
        }
        CartManager.shared.load()
    }
}
