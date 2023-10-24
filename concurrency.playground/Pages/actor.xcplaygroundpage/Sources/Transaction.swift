import Foundation

public enum TransactionType {
    case deposit, withdraw
}

public struct Transaction: Identifiable {
    public let id: String
    public let type: TransactionType
    public let amount: Double
    
    public init(type: TransactionType, amount: Double) {
        self.id = UUID().uuidString
        self.type = type
        self.amount = amount
    }
}
