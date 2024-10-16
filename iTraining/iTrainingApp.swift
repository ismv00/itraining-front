//
//  iTrainingApp.swift
//  iTraining
//
//  Created by Igor S. Menezes on 07/10/24.
//

import SwiftUI

@main
struct iTrainingApp: App {
    
    @StateObject private var userSession = UserSession()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userSession)
        }
    }
}
