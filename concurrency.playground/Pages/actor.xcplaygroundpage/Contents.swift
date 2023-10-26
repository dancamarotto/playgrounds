import PlaygroundSupport
import Foundation

class UnsafeBankAccount {
    private var transactions: [Transaction.ID : Transaction] = [:]
    private var balance: Double = 0
    
    func deposit(_ amount: Double) {
        balance += amount
        let transaction = Transaction(type: .deposit, amount: amount)
        transactions[transaction.id] = transaction
    }
}

class OutdatedBankAccount {
    private var transactions: [Transaction.ID : Transaction] = [:]
    private var balance: Double = 0
    private var transactionsQueue = DispatchQueue(label: "transactions-queue")
    
    func deposit(_ amount: Double) {
        balance += amount
        let transaction = Transaction(type: .deposit, amount: amount)
        transactionsQueue.sync {
            transactions[transaction.id] = transaction
        }
    }
    
    func withdraw(_ amount: Double) {
        assert(balance >= amount, "insufficient funds")
        balance -= amount
        let transaction = Transaction(type: .withdraw, amount: amount)
        transactionsQueue.sync {
            transactions[transaction.id] = transaction
        }
    }
}

actor BankAccount {
    private var transactions: [Transaction.ID : Transaction] = [:]
    private var balance: Double = 0
    private let id: String = UUID().bankID
    
    func deposit(_ amount: Double) {
        balance += amount
        let transaction = Transaction(type: .deposit, amount: amount)
        transactions[transaction.id] = transaction
    }
    
    func withdraw(_ amount: Double) {
        assert(balance >= amount, "insufficient funds")
        balance -= amount
        let transaction = Transaction(type: .withdraw, amount: amount)
        transactions[transaction.id] = transaction
    }
}

extension BankAccount: CustomStringConvertible {
    nonisolated var description: String {
        "BankAccount id: \(id)."
    }
}

// using UnsafeBankAccount will cause a crash over a data race
let myAccount = BankAccount()
print(myAccount)

(0..<1000).forEach { _ in
    Task {
        await myAccount.deposit(Double.random(in: 10...50))
    }
}

// Preserve the content below
PlaygroundPage.current.needsIndefiniteExecution = true
