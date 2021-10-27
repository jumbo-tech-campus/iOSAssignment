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
    private let positionFirstScreen: TabBarPosition = .search

    // MARK: - Life cycle

    init(screens: [UIViewController] = [UIViewController]()) {
        self.screens = screens
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarUI()
    }

    // MARK: - Custom methods

    private func setupTabBarUI() {
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
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

    // MARK: - Create screen

    private func addHomeScreen() {
        //TODO: handle it
        let navigation = UINavigationController()

        navigation.tabBarItem = UITabBarItem(
            title: R.string.localizable.tabBarHomeTitle(),
            image: nil,
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
            image: nil,
            tag: TabBarPosition.recipes.rawValue)

        screens.append(navigation)
    }

    private func addOffersScreen() {
        //TODO: handle it
        let navigation = UINavigationController()

        navigation.tabBarItem = UITabBarItem(
            title: R.string.localizable.tabBarOffersTitle(),
            image: nil,
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

        screens.append(navigation)
    }
}

// MARK: - TabBarController delegate

extension TabBarViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch TabBarPosition(rawValue: tabBarController.tabBar.selectedItem?.tag ?? -1) {
            case .home, .recipes, .offers:
                return false
            case .search, .cart:
                return true
            default:
                return false
        }
    }
}
