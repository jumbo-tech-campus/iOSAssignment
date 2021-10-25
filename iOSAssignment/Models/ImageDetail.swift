public struct ImageDetail: Codable {
    public let url: String
    public let width: UInt
    public let height: UInt
}

public extension Array where Element == ImageDetail {

    var smallestImage: ImageDetail? {
        self.min(by: { $0.width < $1.width })
    }
}
