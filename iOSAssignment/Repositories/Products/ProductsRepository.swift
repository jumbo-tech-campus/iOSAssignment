import Foundation
protocol ProductsRepositoryType {
    func fetchRawProducts() -> Products?
}

struct ProductsRepository: ProductsRepositoryType {

    func fetchRawProducts() -> Products? {
        guard
            let jsonData = Data(fromJsonFile: "products"),
            let list = try? JSONDecoder().decode(Products.self, from: jsonData)
        else { return nil }

        return list
    }
}
