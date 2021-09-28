struct ProductRaw: Codable {
    let id: String
    let title: String
    let prices: ProductPriceDataRaw?
    let available: Bool
    let productType: String?
    let imageInfo: ProductImagesInfoRaw?
    let topLevelCategory: String?
    let topLevelCategoryId: String?
    let quantity: String?
}
