//
//  Response.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

enum Response<T> {
    case success(T)
    case failure(error: ErrorRequest, statusCode: HTTPStatusCode? = nil)
}
