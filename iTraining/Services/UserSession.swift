//
//  UserSession.swift
//  iTraining
//
//  Created by Igor S. Menezes on 13/10/24.
//

import SwiftUI
import Combine

class UserSession: ObservableObject {
    @Published var userId: Int = 0
    @Published var token: String = ""
    @Published var userName: String = ""
}
