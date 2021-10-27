//
//  TabBarCoordinator.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

import UIKit

final class TabBarCoordinator: Coordinator {

    // MARK: - Attributes

    private var tabBarController: UITabBarController?
    private let window: UIWindow

    // MARK: - Life cycle

    init(presenter window: UIWindow) {
        self.window = window
    }

    func start() {
        tabBarController = TabBarViewController()
        tabBarController?.hidesBottomBarWhenPushed = true
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
