//
//  SignupView.swift
//  iTraining
//
//  Created by Igor S. Menezes on 09/10/24.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var userSession : UserSession
    @State private var navigateToHome = false // Controle de navegação para HomeView
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String = ""
    
    
    let sigupService = SignupService()
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("Create Account")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .bold()
                    .padding(.bottom, 30)
                
                TextField("Name", text: $name)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal, 60)
                    .padding(.bottom, 15)
                    .foregroundStyle(.black)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal, 60)
                    .padding(.bottom, 15)
                    .foregroundStyle(.black)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal, 60)
                    .foregroundStyle(.black)
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal, 60)
                    .foregroundStyle(.black)
                
                Button(action: {
                    handleSignup()
                }) {
                    Text("Sign Up")
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
                    Text("Already have an account?")
                        .foregroundStyle(.white)
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Log In")
                            .foregroundStyle(.blue)
                    }
                }
                .padding(.bottom, 30)
            }
        }
        .navigationBarBackButtonHidden(true) // Para esconder o botão de voltar
        .navigationTitle("") // Esconder o título da navegação
        .overlay(
            NavigationLink(destination: HomeView(userId: userSession.userId, token: userSession.token, userName: userSession.userName).environmentObject(userSession) , isActive: $navigateToHome) {
                EmptyView()  // Usado para navegar automaticamente
            }
        )
    }
    
    func handleSignup() {
        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            return
        }
        
        sigupService.signup(name: name, email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("Signup successful!")
                    // Definindo true para `navigateToHome`, redirecionando para a HomeView
                    navigateToHome = true
                    
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}

#Preview {
    SignupView()
}
