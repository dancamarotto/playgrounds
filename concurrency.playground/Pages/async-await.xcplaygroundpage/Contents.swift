import PlaygroundSupport

class ViewModel {
    private let service = Service()
    private let username = "username"
    private let password = "123456"
    
    // nested code using completion handlers.
    func login() {
        print("will login user...")
        service.loginUser(username, password: password) { [weak self] success in
            switch success {
            case .success(let user):
                self?.service.fetchUserData(id: user.id) { success in
                    switch success {
                    case .success(let userInfo):
                        self?.updateUI(userInfo: userInfo)
                    case .failure(let error):
                        print(error.localizedDescription)
                        // handle error...
                    }
                }
                print(user)
            case .failure(let error):
                print(error.localizedDescription)
                // handle error...
            }
        }
    }
    
    // clearer code using async/await
    func loginAsync() async {
        print("will login user...")
        do {
            let user = try await service.loginUser(username, password: password)
            let userInfo = try await service.fetchUserData(id: user.id)
            await updateUIAsync(userInfo: userInfo)
        } catch {
            print(error.localizedDescription)
            // handle error...
        }
    }
    
    func updateUI(userInfo: UserInfo) {
        // updates UI
        print("presenting user info...")
        print("email: \(userInfo.email)")
    }
    
    @MainActor
    func updateUIAsync(userInfo: UserInfo) async {
        // updates UI
        print("presenting user info...")
        print("email: \(userInfo.email)")
    }
}

let viewModel = ViewModel()

//viewModel.login()
Task {
    await viewModel.loginAsync()
}

// Preserve the content below
PlaygroundPage.current.needsIndefiniteExecution = true
