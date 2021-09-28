import Foundation
protocol ProductsRepositoryType {
    func fetchRawProducts() -> Products?
}

public struct ProductsRepository: ProductsRepositoryType {
    func fetchRawProducts() -> Products? {
        let jsonData = Data.init(fromJsonFile: "products")
        do {
            let jsonResponse = try JSONDecoder().decode(Products.self, from: jsonData)
            return jsonResponse
        } catch let error {
            print("Parsing error: \(error)")
            return nil
        }
    }
}

struct Products: Codable {
    let products: [ProductRaw]
}


