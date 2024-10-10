//
//  LoginView.swift
//  iTraining
//
//  Created by Igor S. Menezes on 09/10/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var isLoggedIn: Bool = false
    
    let loginService = LoginService()
    
    var body: some View {
       ZStack {
           Image("background")
               .resizable()
               .scaledToFill()
               .edgesIgnoringSafeArea(.all)
           
           VStack {
               Spacer()
               
               Text("iTraining")
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
               
               SecureField("Password", text: $password)
                   .padding()
                   .background(Color.white.opacity(0.8))
                   .cornerRadius(10)
                   .padding(.horizontal, 60)
                   .foregroundStyle(.black)
               
               Button(action: {
                   handleLogin()
               }) {
                   Text("Login")
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
               
               NavigationLink(destination: HomeView(), isActive: $isLoggedIn) {
                   EmptyView()
               }
           }
        }
    }
    
    func handleLogin() {
        loginService.login(email: email, password: password) { result in
            switch result {
            case .success:
                print("Login successful!")
                isLoggedIn = true
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }
}



#Preview {
    LoginView()
}
