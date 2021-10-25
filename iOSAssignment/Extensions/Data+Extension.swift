import Foundation

extension Data {

    init?(fromJsonFile filename: String) {
        guard
            let filePath = Bundle.main.path(forResource: filename, ofType: "json")
            else { return nil }

        do {
            try self.init(contentsOf: URL(fileURLWithPath: filePath))
        } catch {
            return nil
        }
    }
}
