//
//  FileDecoder.swift
//  iOSAssignment
//
//  Created by Jader Nunes on 27/10/21.
//

import Foundation

struct FileDecoder {

    func decode<T: Decodable>(resource: JSONFiles) -> T? {
        guard
            let jsonUrl = Bundle.main.url(forResource: resource.rawValue, withExtension: "json"),
            let jsonData = try? Data(contentsOf: jsonUrl),
            let response = try? JSONDecoder.decoder.decode(T.self, from: jsonData)
        else {
            debugPrint("Error on Json decoding")
            return nil
        }

        return response
    }
}
