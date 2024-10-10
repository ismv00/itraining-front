//
//  ContentView.swift
//  iTraining
//
//  Created by Igor S. Menezes on 09/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            LoginView()
                .navigationBarHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
