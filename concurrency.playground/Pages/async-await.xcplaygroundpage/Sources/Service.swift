import Foundation

public struct Service {
    
    public init() { }
    
    /// Logs in a user with the provided username and password.
    /// - Parameters:
    ///   - username: The username of the user.
    ///   - password: The password for the user.
    ///   - completionHandler: The closure to be executed upon completion.
    public func loginUser(_ username: String, password: String, completionHandler: @escaping (Result<User, Error>) -> Void) {
        DispatchQueue.main
            .asyncAfter(deadline: .now() + 1.5) {
                let user = User(username: username)
                completionHandler(.success(user))
            }
    }
    
    /// Fetches user data for the given ID.
    /// - Parameters:
    ///   - id: The user ID.
    ///   - completionHandler: The closure to be executed upon completion.
    public func fetchUserData(id: String, completionHandler: @escaping (Result<UserInfo, Error>) -> Void) {
        DispatchQueue.main
            .asyncAfter(deadline: .now() + 1) {
                let userInfo = UserInfo(email: "user@email.com")
                completionHandler(.success(userInfo))
            }
    }
    
    /// Logs in a user with the provided username and password.
    /// - Parameters:
    ///   - username: The username of the user.
    ///   - password: The password for the user.
    /// - Returns: the logged in `User`
    /// - Throws: If the login process encounters a problem, this function throws an `Error`.
    public func loginUser(_ username: String, password: String) async throws -> User {
        try await Task.sleep(until: .now + .seconds(1.5), clock: .continuous)
        return User(username: username)
    }
    
    /// Fetches user data for the given ID.
    /// - Parameter id: The user ID.
    /// - Returns: The `UserInfo`.
    /// - Throws: If the fetch user data process encounters a problem, this function throws an `Error`.
    public func fetchUserData(id: String) async throws -> UserInfo {
        try await Task.sleep(until: .now + .seconds(1), clock: .continuous)
        return UserInfo(email: "user@email.com")
    }
}
