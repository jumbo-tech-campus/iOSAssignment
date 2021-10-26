//
//  UIViewController+Extension.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 26/10/21.
//

import UIKit

extension UIViewController {

    func configureNavigationBar(isHidden: Bool = false,
                                isTranslucent: Bool = false) {
        navigationController?.isNavigationBarHidden = isHidden
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.isTranslucent = isTranslucent
        navigationController?.navigationBar.tintColor = isHidden ? .clear : .red
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.red,
            .font: UIFont.systemFont(ofSize: 17)
        ]
    }
}
