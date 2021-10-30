//
//  UITableView+Extension.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 28/10/21.
//

import UIKit

extension UITableView {

    @discardableResult func registerClass<T: UITableViewCell>(cellType: T.Type) -> UITableView {
        register(cellType, forCellReuseIdentifier: cellType.className)
        return self
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        guard
            let reusableCell = self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T
        else {
            //TODO: Send error to crashlytics
            return T(frame: .zero)
        }
        return reusableCell
    }
}
