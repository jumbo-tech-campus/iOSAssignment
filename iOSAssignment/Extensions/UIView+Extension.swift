//
//  UIView+Extension.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 26/10/21.
//

import UIKit

// MARK: - General

extension UIView {

    /// Used to work arout the activity indicator to show when the view is loading
    var tagLoader: Int { 9999 }
    
    @discardableResult func addView(_ view: UIView) -> UIView {
        addSubview(view)
        return self
    }

    func startLoader(style: UIActivityIndicatorView.Style = .medium) {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        loader.style = style
        loader.tag = tagLoader

        addView(loader)
        loader.startAnimating()
        loader.centerInSuperview()
    }

    func stopLoader() {
        viewWithTag(tagLoader)?.removeFromSuperview()
    }
}

// MARK: - Constraints

extension UIView {
    
    @discardableResult func centerInSuperview() -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return self }

        centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: 0).isActive = true
        centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: 0).isActive = true

        return self
    }
}
