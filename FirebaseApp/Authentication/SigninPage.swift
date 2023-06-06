
import SwiftUI

//@MainActor
//final class SignInEmailViewModel: ObservableObject {
//    
//    @Published var email = ""
//    @Published var password = ""
//    func signIn() {
//        guard !email.isEmpty, !password.isEmpty else {
//            print("No email or password found.")
//            return
//        }
//        Task {
//            do {
//                let returnedUserData = try await AuthenticationManager.shared.createUser (email: email, password: password)
//                print("Success")
//                print (returnedUserData)
//            } catch {
//                print ("Error: \(error)")
//            }
//        }
//    }
//}

struct SigninPage: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SigninPage_Previews: PreviewProvider {
    static var previews: some View {
        SigninPage()
    }
}
