//
//  Array+Extension.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 25/10/21.
//

extension Array where Element == ImageDetail {

    var smallestImage: ImageDetail? {
        self.min(by: { $0.width < $1.width })
    }
}
