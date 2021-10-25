import Foundation
protocol ProductsRepositoryType {
    func fetchRawProducts() -> Products?
}

public struct ProductsRepository: ProductsRepositoryType {

    func fetchRawProducts() -> Products? {
        let jsonData = Data.init(fromJsonFile: "products")
        do {
            return try JSONDecoder().decode(Products.self, from: jsonData)
        } catch {
            return nil
        }
    }
}
