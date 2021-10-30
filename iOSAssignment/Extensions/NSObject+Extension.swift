//
//  NSObject+Extension.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 28/10/21.
//

import Foundation

protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {

    public static var className: String {
        String(describing: self)
    }

    public var className: String {
        type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
