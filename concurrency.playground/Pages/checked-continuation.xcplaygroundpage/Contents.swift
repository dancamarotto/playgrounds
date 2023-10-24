import PlaygroundSupport

struct AsyncService {
    private let service = Service()
    
    func loginUser(_ username: String, password: String) async throws -> User {
        try await withCheckedThrowingContinuation { continuation in
            service.loginUser(username, password: password) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    func fetchUserData(id: String) async throws -> UserInfo {
        try await withCheckedThrowingContinuation { continuation in
            service.fetchUserData(id: id) { result in
                continuation.resume(with: result)
            }
        }
    }
}

class ViewModel {
    private let service = AsyncService()
    private let username = "username"
    private let password = "123456"
    
    func loginAsync() async {
        print("will login user...")
        do {
            let user = try await service.loginUser(username, password: password)
            let userInfo = try await service.fetchUserData(id: user.id)
            await updateUI(userInfo: userInfo)
        } catch {
            print(error.localizedDescription)
            // handle error...
        }
    }
    
    @MainActor
    func updateUI(userInfo: UserInfo) async {
        // updates UI
        print("presenting user info...")
        print("email: \(userInfo.email)")
    }
}

let viewModel = ViewModel()

Task {
    await viewModel.loginAsync()
}

// Preserve the content below
PlaygroundPage.current.needsIndefiniteExecution = true
