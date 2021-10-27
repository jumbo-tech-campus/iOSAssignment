//
//  ErrorRequest.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

enum ErrorRequest: Error {
    case custom(message: String)
    case generic(message: String = R.string.localizable.errorInternal())
    case genericWith(error: Error)
    case noInternet(message: String = R.string.localizable.errorNoInternet())

    var message: String {
        switch self {
            case .custom(let message):
                return message
            case .generic(let message):
                return message
            case .genericWith(_):
                //TODO: handle the error model
                return R.string.localizable.errorInternal()
            case .noInternet(let message):
                return message
        }
    }
}
