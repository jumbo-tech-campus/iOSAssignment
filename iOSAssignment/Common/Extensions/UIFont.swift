//
//  UIFont.swift
//  iOSAssignment
//
//  Created by David Velarde on 19/12/2021.
//

import UIKit

extension UIFont {
    class func jumboNumbersBold(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "TheSansBold-Expert", size: size) ?? .systemFont(ofSize: size)
    }
    class func jumboNumbersBlack(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "TheSans-B9Black", size: size) ?? .systemFont(ofSize: size)
    }
    class func jumboTextBoldCaps(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "TheSansBold-Caps", size: size) ?? .systemFont(ofSize: size)
    }
    class func jumboTextBlackCaps(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "TheSansBlack-Caps", size: size) ?? .systemFont(ofSize: size)
    }
    class func jumboTextBlack(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "TheSansBlack-Plain", size: size) ?? .systemFont(ofSize: size)
    }
    class func jumboText(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "TheSans-B5Plain", size: size) ?? .systemFont(ofSize: size)
    }
    class func jumboTextBold(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "TheSans-B7Bold", size: size) ?? .systemFont(ofSize: size)
    }
}
