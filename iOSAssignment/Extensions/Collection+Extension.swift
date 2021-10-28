//
//  Collection+Extension.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

import Foundation

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
