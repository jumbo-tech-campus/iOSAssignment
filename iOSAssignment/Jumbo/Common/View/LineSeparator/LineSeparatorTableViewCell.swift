//
//  LineSeparatorTableViewCell.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//

import UIKit

final class LineSeparatorTableViewCell: BaseTableViewCell<LineSeparatorTableViewCellViewModel> {
    
    @IBOutlet weak var containerBkgView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var lineHeightConstraint: NSLayoutConstraint!
    
      
    override func bind() {
        containerView.isHidden = viewModel.isLineSeparatorHidden
        containerBkgView.backgroundColor = viewModel.backgroundColor
        containerView.backgroundColor = viewModel.separatorColor
        leadingConstraint.constant = viewModel.spacingLeft
        trailingConstraint.constant = viewModel.spacingRight
        bottomConstraint.constant = viewModel.spacingBottom
        topConstraint.constant = viewModel.spacingTop
        lineHeightConstraint.constant = viewModel.lineHeight
    }
    
}
