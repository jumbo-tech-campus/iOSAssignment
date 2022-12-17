//
//  LineSeparatorTableViewCellViewModel.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//

import Foundation
import UIKit

enum LineSeparatorType {
    case `default`
    case  empty
}

class LineSeparatorTableViewCellViewModel: BaseTableViewCellViewModel {
    
    let backgroundColor: UIColor
    let separatorColor: UIColor
    let lineHeight: CGFloat
    let spacingLeft: CGFloat
    let spacingRight: CGFloat
    let spacingTop: CGFloat
    let spacingBottom: CGFloat
    let isLineSeparatorHidden: Bool
    
    init(lineSeparatorType: LineSeparatorType = .default
        , backgroundColor: UIColor = .clear
         , separatorColor: UIColor = UIColor.lightGray.withAlphaComponent(0.2)
        , lineHeight: CGFloat = 1.0
        , cellHeight: CGFloat = 1.0
        , spacingLeft: CGFloat = 20.0
        , spacingRight: CGFloat = 20.0
        , spacingTop: CGFloat = 0.0
        , spacingBottom: CGFloat = 0.0
    ) {
        self.isLineSeparatorHidden = (lineSeparatorType == .default) ? false : true
        self.backgroundColor = backgroundColor
        self.separatorColor = separatorColor
        self.lineHeight = lineHeight
        self.spacingLeft = spacingLeft
        self.spacingRight = spacingRight
        self.spacingTop = spacingTop
        self.spacingBottom = spacingBottom
        
        super.init(cellHeight: cellHeight)
    }
}
