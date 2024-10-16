//
//  LoginView.swift
//  iTraining
//
//  Created by Igor S. Menezes on 09/10/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var userSession = UserSession()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var navigateToHome = false
    
    @State private var userId: Int = 0
    @State private var token: String = ""
    @State private var userName: String = ""
    
    
    let loginService = LoginService()
    
    var body: some View {
       ZStack {
           Image("background")
               .resizable()
               .scaledToFill()
               .edgesIgnoringSafeArea(.all)
           
           VStack {
               Spacer()
               
               Text("Login")
                   .font(.largeTitle)
                   .foregroundColor(.white)
                   .bold()
                   .padding(.bottom, 30)
               
               TextField("Email", text: $email)
                   .padding()
                   .background(Color.white.opacity(0.8))
                   .cornerRadius(10)
                   .padding(.horizontal, 60)
                   .padding(.bottom, 15)
                   .foregroundColor(.black)
                   .autocapitalization(.none)
                   .keyboardType(.emailAddress)
                   .disableAutocorrection(true)
               
               SecureField("Password", text: $password)
                   .padding()
                   .background(Color.white.opacity(0.8))
                   .cornerRadius(10)
                   .padding(.horizontal, 60)
                   .foregroundStyle(.black)
               
               Button(action: {
                   handleLogin()
               }) {
                   Text("Log In")
                       .frame(maxWidth: .infinity)
                       .padding()
                       .background(Color.blue)
                       .foregroundStyle(.white)
                       .cornerRadius(10)
                       .padding(.horizontal, 60)
                       .padding(.top, 20)
               }
               
               Spacer()
               
               if !errorMessage.isEmpty {
                   Text(errorMessage)
                       .foregroundStyle(.red)
                       .padding(.bottom, 10)
               }
               
               HStack {
                   Text("Don't have an account?")
                       .foregroundStyle(.white)
                   
                   NavigationLink(destination: SignupView()) {
                       Text("Sign Up")
                           .foregroundStyle(.blue)
                   }
               }
               .padding(.bottom, 30)
           }
        }
       .navigationBarBackButtonHidden(true)
       .navigationTitle("")
       .overlay(
        NavigationLink(destination: HomeView(userId: userSession.userId, token: userSession.token, userName: userSession.userName)
            .environmentObject(userSession)
                        ,isActive: $navigateToHome) {
            EmptyView()
        }
       )
    }
    
    func handleLogin() {
        loginService.login(email: email, password: password) { result in
            switch result {
            case .success(let (token, userId, userName)):
                print("Login successful Token: \(token)")
                
                DispatchQueue.main.async {
                    userSession.token = token
                    userSession.userId = userId
                    userSession.userName = userName
                    navigateToHome = true
                }
 
            case .failure(let error) :
                DispatchQueue.main.async {
                    if let APIError = error as? APIError {
                        errorMessage = APIError.error
                    } else {
                        errorMessage = "Ocorreu um erro inesperado. Tente novamente."
                    }
                }
            }
        }
    }
}



#Preview {
    LoginView()
}
