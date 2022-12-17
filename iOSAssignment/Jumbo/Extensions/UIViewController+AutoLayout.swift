//
//  UIViewController+AutoLayout.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//

import Foundation
import UIKit

public extension UIViewController {
    var safeTopAnchor: NSLayoutYAxisAnchor {
            return view.safeAreaLayoutGuide.topAnchor
    }

    var safeBottomAnchor: NSLayoutYAxisAnchor {
            return view.safeAreaLayoutGuide.bottomAnchor
    }

    var safeLeadingAnchor: NSLayoutXAxisAnchor {
            return view.safeAreaLayoutGuide.leadingAnchor
    }

    var safeTrailingAnchor: NSLayoutXAxisAnchor {
            return view.safeAreaLayoutGuide.trailingAnchor
    }
}
