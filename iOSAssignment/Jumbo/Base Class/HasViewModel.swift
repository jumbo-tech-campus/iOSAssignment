//
//  HasViewModel.swift
//  iOSAssignment
//
//  Created by Ramkrishna Baddi on 17/12/2022.
//

import Foundation

protocol HasViewModel {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType! { get set }
}
