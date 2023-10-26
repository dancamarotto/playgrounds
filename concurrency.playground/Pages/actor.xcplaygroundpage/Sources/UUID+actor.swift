import Foundation

extension UUID {
    public var bankID: String {
        uuidString
            .split(separator: "-", maxSplits: 1)
            .first
            .map { String($0) }!
    }
}
