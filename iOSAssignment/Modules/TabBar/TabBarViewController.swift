//
//  TabBarViewController.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 26/10/21.
//

import UIKit
import Rswift

final class TabBarViewController: UITabBarController {

    // MARK: - Attributes

    private var screens: [UIViewController]
    private let positionFirstScreen: TabBarPosition = .home
    private let cart: CartManagerProtocol
    private let notification: NotificationCenter

    // MARK: - Life cycle

    init(screens: [UIViewController] = [UIViewController](),
         cart: CartManagerProtocol = CartManager(),
         notification: NotificationCenter = .default) {
        self.screens = screens
        self.cart = cart
        self.notification = notification

        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        updateCountItemsCart()
        subscripObersvers()
    }

    // MARK: - Custom methods

    private func setupUI() {
        let fontAttributes = [NSAttributedString.Key.font: UIFont.subDetail]
        UITabBarItem
            .appearance()
            .setTitleTextAttributes(fontAttributes, for: .normal)

        tabBar.unselectedItemTintColor = .lightGray
        tabBar.tintColor = .clPrimary
        tabBar.barTintColor = .white
        tabBar.isTranslucent = true
        delegate = self

        if screens.isEmpty {
            addHomeScreen()
            addSearchScreen()
            addRecipesScreen()
            addOffersScreen()
            addCartScreen()
        }

        viewControllers = screens
        selectedIndex = positionFirstScreen.rawValue
    }

    private func subscripObersvers() {
        notification.addObserver(self,
                                 selector: #selector(updateCountItemsCart),
                                 name: NSNotification.Name(rawValue: .keyNotifyCartChanged),
                                 object: nil)
    }

    @objc private func updateCountItemsCart() {
        let countProducts = cart.countAll()
        screens[TabBarPosition.cart.rawValue]
            .tabBarItem
            .badgeValue = countProducts > 0 ? countProducts.description : nil
    }

    // MARK: - Create screen

    private func addHomeScreen() {
        //TODO: handle it
        let navigation = UINavigationController()
        let coordinator = HomeCoordinator(presenter: navigation)
        coordinator.start()
        coordinator.delegate = self

        navigation.tabBarItem = UITabBarItem(
            title: R.string.localizable.tabBarHomeTitle(),
            image: R.image.iconHomeTabBar(),
            tag: TabBarPosition.home.rawValue)

        screens.append(navigation)
    }

    private func addSearchScreen() {
        let navigation = UINavigationController()
        let coordinator = SearchCoordinator(presenter: navigation)
        coordinator.start()

        navigation.tabBarItem = UITabBarItem(
            title: R.string.localizable.tabBarSearchTitle(),
            image: R.image.iconSearchTabBar(),
            tag: TabBarPosition.search.rawValue)

        screens.append(navigation)
    }

    private func addRecipesScreen() {
        //TODO: handle it
        let navigation = UINavigationController()

        navigation.tabBarItem = UITabBarItem(
            title: R.string.localizable.tabBarRecipesTitle(),
            image: R.image.iconRecipesTabBar(),
            tag: TabBarPosition.recipes.rawValue)

        screens.append(navigation)
    }

    private func addOffersScreen() {
        //TODO: handle it
        let navigation = UINavigationController()

        navigation.tabBarItem = UITabBarItem(
            title: R.string.localizable.tabBarOffersTitle(),
            image: R.image.iconOffersTabBar(),
            tag: TabBarPosition.offers.rawValue)

        screens.append(navigation)
    }

    private func addCartScreen() {
        //TODO: handle it
        let navigation = UINavigationController()

        navigation.tabBarItem = UITabBarItem(
            title: R.string.localizable.tabBarCartTitle(),
            image: R.image.iconCartTabBar(),
            tag: TabBarPosition.cart.rawValue)
        navigation.tabBarItem.badgeColor = .customRed

        screens.append(navigation)
    }
}

// MARK: - TabBarController delegate

extension TabBarViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch TabBarPosition(rawValue: tabBarController.tabBar.selectedItem?.tag ?? -1) {
            case .recipes, .offers:
                return false
            case .home, .search, .cart:
                return true
            default:
                return false
        }
    }
}

// MARK: - Home delegate {

extension TabBarViewController: HomeDelegate {

    func openSearchDidPress() {
        selectedIndex = TabBarPosition.search.rawValue
    }
}
