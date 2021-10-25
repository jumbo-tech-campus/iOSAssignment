struct ProductPriceData: Codable {
    let price: ProductPrice?
    let unitPrice: ProductUnitPrice?
    let promotionalPrice: ProductPrice?
}

public struct ProductPrice: Codable {
    let currency: String
    let amount: Int
}

struct ProductUnitPrice: Codable {
    let price: ProductPrice?
    let unit: String?
    let unitAmount: String?
}
