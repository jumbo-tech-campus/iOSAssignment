//
//
//  HasDisposeBag.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//

import Foundation
import RxSwift

protocol HasDisposeBag {
    var disposeBag: DisposeBag { get set }
}
