import Foundation

public extension Data {
    init(fromJsonFile filename: String) {
        let filePath = Bundle.main.path(forResource: filename, ofType: "json")!
        try! self.init(contentsOf: URL(fileURLWithPath: filePath))
    }
}
