//
//  LoginService.swift
//  iTraining
//
//  Created by Igor S. Menezes on 09/10/24.
//

import Foundation

class LoginService {
    func login(email: String, password: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if email.contains("@") && password.count > 6 {
                completion(.success(true))
            } else {
                completion(.failure(NSError(domain: "Login Failed", code: 400, userInfo: [NSLocalizedDescriptionKey: "E-mail ou senha incorretos."])))
            }
        }
        
    }
}
