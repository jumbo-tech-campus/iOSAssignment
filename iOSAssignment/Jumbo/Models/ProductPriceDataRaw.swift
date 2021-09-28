struct ProductPriceDataRaw: Codable {
    let price: ProductPriceRaw?
    let unitPrice: ProductUnitPriceRaw?
    let promotionalPrice: ProductPriceRaw?
}

public struct ProductPriceRaw: Codable {
    let currency: String
    let amount: Int
}

struct ProductUnitPriceRaw: Codable {
    let price: ProductPriceRaw?
    let unit: String?
    let unitAmount: String?
}
