//
//  View.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//

import UIKit
import RxSwift

protocol ViewType: HasDisposeBag {
}

class View: UIView, ViewType {
    var disposeBag = DisposeBag()

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    
    
    /// A property that accesses the backing layer's shadow
    @IBInspectable
    open var shadowColor: UIColor? {
        get {
            guard let value = layer.shadowColor else {
                return nil
            }
            
            return UIColor(cgColor: value)
        }
        set(value) {
            layer.shadowColor = value?.cgColor
        }
    }
    
    /// A property that accesses the backing layer's shadowOffset.
    @IBInspectable
    open var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set(value) {
            layer.shadowOffset = value
        }
    }
    
    /// A property that accesses the backing layer's shadowOpacity.
    @IBInspectable
    open var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set(value) {
            layer.shadowOpacity = value
        }
    }
    
    /// A property that accesses the backing layer's shadowRadius.
    @IBInspectable
    open var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set(value) {
            layer.shadowRadius = value
        }
    }
    
    /// A property that accesses the backing layer's shadowPath.
    @IBInspectable
    open var shadowPath: CGPath? {
        get {
            return layer.shadowPath
        }
        set(value) {
            layer.shadowPath = value
        }
    }
}

extension UIView {
    /// Use only to dispose of subscriptions inside resuable views
    func nukeDisposeBags() {
        if var hasDisposeBagView = self as? HasDisposeBag {
            hasDisposeBagView.disposeBag = DisposeBag()
        }

        let subViews = self.subviews

        guard subViews.count == 0 else { return }

        for subView in subViews {
            subView.nukeDisposeBags()
        }
    }
}
