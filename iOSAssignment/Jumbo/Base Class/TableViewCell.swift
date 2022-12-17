//
//  TableViewCell.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//

import RxSwift
import UIKit

class TableViewCell: UITableViewCell, HasDisposeBag {
    var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        nukeDisposeBags()
    }
}

extension UITableViewCell: ReusableView {}

