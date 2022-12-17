//
//  ReusableView.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//

import Foundation

import class UIKit.UITableViewCell
import class UIKit.UITableView

protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
