//
//  TabBarCoordinator.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

import UIKit

protocol TabBarCoordinatorProtocol: Coordinator {
    func openSearch()
}

final class TabBarCoordinator: TabBarCoordinatorProtocol {

    // MARK: - Attributes

    private let firstScreen: TabBarPosition
    private var tabBarController: UITabBarController?
    private let window: UIWindow

    // MARK: - Life cycle

    init(presenter window: UIWindow, firstScreen: TabBarPosition = .home) {
        self.window = window
        self.firstScreen = firstScreen
    }

    func start() {
        let viewModel = TabBarViewModel(coordinator: self)
        tabBarController = TabBarViewController(viewModel: viewModel)
        tabBarController?.hidesBottomBarWhenPushed = true
        tabBarController?.selectedIndex = firstScreen.rawValue
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    func openSearch() {
        tabBarController?.selectedIndex = TabBarPosition.search.rawValue
    }
}
