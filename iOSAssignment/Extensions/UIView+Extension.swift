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

    @discardableResult func addShadow(_ offset: CGSize = .init(width: -0.05, height: 0.05)) -> UIView  {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = offset
        layer.shadowRadius = 2
        layer.masksToBounds = false
        return self
    }
}

protocol Component {
    associatedtype Configuration

    func render(with configuration: Configuration)
}

func create<T: UIView>(configure: ((T) -> Void)? = nil) -> T {

    let component = T()
    component.translatesAutoresizingMaskIntoConstraints = false
    configure?(component)

    return component
}

// MARK: - Constraints

extension UIView {

    @discardableResult func pinToBounds(of view: UIView,
                     topConstant: CGFloat = 0,
                     leadingConstant: CGFloat = 0,
                     bottomConstant: CGFloat = 0,
                     trailingConstant: CGFloat = 0) -> UIView {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingConstant),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomConstant),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingConstant)
        ])
        return self
    }
    
    @discardableResult func centerInSuperview() -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return self }

        NSLayoutConstraint.activate([
            centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: 0),
            centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: 0)
        ])

        return self
    }
}
