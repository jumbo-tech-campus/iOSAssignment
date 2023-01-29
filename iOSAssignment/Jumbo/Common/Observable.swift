//
//  Observable.swift
//  iOSAssignment
//
//  Created by Spam C. on 1/29/23.
//

import Foundation

class Observable<T> {
    var value: T {
        willSet {
            DispatchQueue.main.async {
                for observer in self.observers {
                    observer?(self.value)
                }
            }
        }
    }

    private var observers: [((T) -> Void)?] = []

    init(value: T) {
        self.value = value
    }

    /// Add closure as an observer and trigger the closure imeediately if fireNow = true
    func addObserver(fireNow: Bool = false, _ onChange: ((T) -> Void)?) {
        observers.append(onChange)
        if fireNow {
            onChange?(value)
        }
    }

    func removeObserver() {
        observers = []
    }
}
