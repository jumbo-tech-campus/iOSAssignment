//
//  ViewModel.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//

import Foundation
import RxSwift

protocol ViewModelType: HasDisposeBag {
}

class ViewModel: NSObject, ViewModelType {
    var disposeBag = DisposeBag()

    fileprivate static var activeViewModelUuid: String = Foundation.UUID().uuidString
    
    func setAsActive() {
        ViewModel.activeViewModelUuid = UUID
    }

    var isActive: Bool {
        return ViewModel.activeViewModelUuid == UUID
    }

    let UUID = Foundation.UUID().uuidString

}
