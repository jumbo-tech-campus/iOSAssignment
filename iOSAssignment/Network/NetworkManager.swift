//
//  NetworkManager.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

import Alamofire

typealias CompletionRequest<T: Decodable> = ((Response<T>) -> Void)

protocol NetworkManagerProtocol {
    func makeRequest<T: Decodable>(requester: Requestable, _ completion: @escaping CompletionRequest<T>)
}

extension Session: NetworkManagerProtocol {

    func makeRequest<T: Decodable>(requester: Requestable, _ completion: @escaping CompletionRequest<T>) {
        guard
            let isReachable = NetworkReachabilityManager.default?.isReachable,
            isReachable
        else {
            DispatchQueue.main.async {
                completion(.failure(error: .noInternet()))
            }
            return
        }

        printRequest(request: requester)
        request(requester)
            .validate()
            .responseDecodable(
                queue: DispatchQueue.global(qos: .userInitiated),
                decoder: JSONDecoder.decoder) { (response: DataResponse<T, AFError>) in
                DispatchQueue.main.async {
                    let statusCode = HTTPStatusCode(rawValue: response.response?.statusCode ?? -1)
                    switch response.result {
                        case .success(let value):
                            printResponse(response)
                            completion(.success(value))
                        case .failure(let error):
                            printResponse(response)
                            completion(.failure(error: .genericWith(error: error),
                                                statusCode: statusCode))
                    }
                }
            }
    }
}

// MARK: - Debug prints

private func printRequest(request: Requestable?) {
    #if DEBUG
    print("\n\n**********  REQUEST   **************")
    print("\(request?.urlRequest?.httpMethod ?? "") - URL: ", request?.urlRequest?.url ?? "")
    print("HEADER: ", request?.urlRequest?.allHTTPHeaderFields?.toJson() ?? "")
    print("BODY: ", request?.parameters ?? "")
    print("****************************************\n\n")
    #endif
}

private func printResponse<T: Decodable>(_ response: DataResponse<T, AFError>) {
    #if DEBUG
    print("\n\n**********  RESPONSE   **************")

    let statusCode = response.response?.statusCode ?? -1
    let httpMethod = response.request?.httpMethod ?? ""
    let url = response.request?.description ?? ""

    print("STATUS_CODE: \(statusCode) - \(httpMethod) - URL: ", url)

    do {
        if let json = try JSONSerialization.jsonObject(with: response.data ?? Data(), options: []) as? [String: Any] {
            print("RESULT: \(json)")
        } else if let json = try JSONSerialization.jsonObject(with: response.data ?? Data(), options: []) as? [[String: Any]] {
            print("RESULT: \(json)")
        }
    } catch let error as NSError {
        print("Failed to parse Result: \(error.localizedDescription)")
    }

    print("****************************************\n\n")
    #endif
}
