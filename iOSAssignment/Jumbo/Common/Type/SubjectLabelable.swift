//
//  SubjectLabelable.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//

import Foundation

protocol SubjectLabelable {
    static var subjectLabel: String { get }
    var subjectLabel: String { get }
}

extension SubjectLabelable {
    static var subjectLabel: String {
        let result = String(describing: Self.self)
        return result
    }

    var subjectLabel: String {
        let result = String(describing: type(of: self))
        return result
    }
}

extension NSObject: SubjectLabelable {}
