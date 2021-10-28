//
//  Dynamic.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

import Foundation

/// We are using this approach to enable to subscribe(bind) an element from the ViewModel to a ViewController.
/// - Attention: Subscribe it only once. If we'll call `bind` twice, the first occurrence will be overridden
/// - Precondition: In the ViewModel:
/// ```
/// let isLoading = Dynamic<Bool>(false)`
/// ```
/// - Postcondition: In the ViewConrtoller:
/// ```
/// func bindStatusLoader() {
///   viewModel.isLoading.bind { [weak self] isLoading in
///     ...
///   }
/// }
/// ```
final class Dynamic<T> {
  typealias Listener = (T) -> Void

  // MARK: - Attributes

  private var listener: Listener?
  var value: T {
    didSet {
      listener?(value)
    }
  }

  // MARK: - Life cycle

  init(_ value: T) {
    self.value = value
  }

  // MARK: - Custom methods

  func bind(_ listener: Listener?) {
    self.listener = listener
  }

  func bindAndFire(_ listener: Listener?) {
    self.listener = listener
    listener?(value)
  }

  func fire() {
    listener?(value)
  }
}
