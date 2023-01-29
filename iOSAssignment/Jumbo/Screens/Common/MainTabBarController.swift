//
//  File.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/19/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    var cartManager: CartManager! {
        didSet {
            viewControllers?.forEach({ controller in
                if let controller = controller as? ProductsController {
                    controller.cartManager = cartManager
                }
            })
        }
    }
    
    var cartTabBarItem: UITabBarItem? {
        return tabBar.items?.first(where: { $0.title == "Cart" })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        cartManager = appDelegate.cartManager
        cartManager.cart.addObserver { [weak self] cart in
            self?.cartTabBarItem?.badgeValue = cart.count > 0 ? "\(cart.count)" : nil
        }
        cartManager.load()
    }
}
