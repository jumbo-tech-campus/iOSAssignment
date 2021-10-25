struct Product: Codable {
    let id: String
    let title: String
    let prices: ProductPriceData?
    let available: Bool
    let productType: String?
    let imageInfo: ProductImagesInfo?
    let topLevelCategory: String?
    let topLevelCategoryId: String?
    let quantity: String?
}
