public struct ImageDetailRaw: Codable {
    public let url: String
    public let width: UInt
    public let height: UInt
}

public extension Array where Element == ImageDetailRaw {
    var smallestImage: ImageDetailRaw? {
        return self.min(by: { (lhs, rhs) -> Bool in
            return lhs.width < rhs.width
        })
    }
}
