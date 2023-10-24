import Foundation

public struct User {
    public let username: String
    public let id: String
    
    public init(username: String) {
        self.username = username
        self.id = UUID().uuidString
    }
}

public struct UserInfo {
    public let email: String
    
    public init(email: String) {
        self.email = email
    }
}
