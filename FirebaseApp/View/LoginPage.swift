
import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser (email: email, password: password)
                print("Success")
                print (returnedUserData)
            } catch {
                print ("Error: \(error)")
            }
        }
    }
}

struct LoginPage: View {
    
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    @StateObject var manager = TFManager()

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // Login Page Form..
            VStack(spacing: 15){
                //                Text ("Login")
                //                    .font(.custom(customFont, size: 22).bold())
                //                    .frame(maxWidth: .infinity, alignment: .leading)
                // Custom Text Field..
                CustomTextField(icon: "envelope", title: "Email", hint: "example@example.com", value: $loginData.email, showPassword:
                        .constant(false))
                .padding(.top, 30)
                
                VStack {
                    CustomTextField(icon: "lock", title: "Password", hint: "Your Password", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top, 10)
                    HStack {
                        Spacer()
                        Text ("\(manager.text.count) /10")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.trailing)
                            .padding(.top, 4)
                    }
                }
                
                // Regsiter Renter Password
                if loginData.registerUser{
                    CustomTextField(icon: "envelope", title: "Re-Enter Password", hint: "Confirm Your Password", value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterPassword)
                        .padding(.top, 10)
                    Spacer()
                    Text ("\(manager.text.count) /15")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                        .padding(.top, 4)
                }
                Button {
                    loginData.ForgotPassword()
//                    viewModel.sianIn()
                } label: {
                    Text("Forgot password?")
                    //                        .font(.custom(customFont, size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Purple"))
                }
                .padding(.top, 8)
                .frame (maxWidth: .infinity, alignment: .leading)
            
            // Login Button..
            Button {
                if loginData.registerUser {
                    loginData.Register()
                }
                else{
                    loginData.Login()
                }
            } label: {
                Text ("Forgot password?")
                //                    .font(.custom(customFont, size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.blue)
            }
            .padding(.top, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
                
            }
        .padding(30)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.white
            // Applying Custom Corners..
//                            .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                .ignoresSafeArea()
        )
    }
    
    @ViewBuilder
    func CustomTextField(icon: String, title: String, hint:
                         String, value: Binding<String>, showPassword:
                         Binding<Bool>)->some View {
        VStack(alignment: .leading, spacing: 12) {
            Label {
                Text(title)
                //        .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            if title.contains("Password") &&
                !showPassword.wrappedValue{
                SecureField(hint, text: value)
                    .padding(.top, 2)
            }
            else{
                TextField(hint, text: value)
                    .padding(.top, 2)
            }
            Divider()
                .background(Color.black.opacity(0.4))
        }
        // Showing Show Button for password Field.
        .overlay(
            Group{
                if title.contains("Password"){
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" :
                                "Show")
                        //    .font(.custom(customFont, size: 13).bold())
                        .foregroundColor(Color.blue)
                    })
                    .offset(y: 8)
                }
            }
            ,alignment: .trailing
        )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}

class TFManager: ObservableObject {
    @Published var text = "" {
        
        didSet {
            if text.count >= 15 && oldValue.count <= 15 {
                text = oldValue
            }
        }
    }
}
