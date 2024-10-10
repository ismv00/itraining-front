//
//  HomeView.swift
//  iTraining
//
//  Created by Igor S. Menezes on 09/10/24.
//

import SwiftUI

struct HomeView: View {
    @State private var navigateToLogin = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Button(action: {
                        handleLogout()
                    }) {
                        Text("Logout")
                            .foregroundStyle(.red)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                    }
                    .padding(.top, 40)
                    
                    Spacer()
                    
                    Text("Welcome to iTrainning!")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .bold()
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("")
            .overlay(
                NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                    EmptyView()
                }
            )
        }
  
    }
    func handleLogout() {
            //
        navigateToLogin = true
        }
}

#Preview {
    HomeView()
}
