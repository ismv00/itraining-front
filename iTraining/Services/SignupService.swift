//
//  SignupService.swift
//  iTraining
//
//  Created by Igor S. Menezes on 09/10/24.
//

import Foundation

class SignupService {
    func signup(email: String, password: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        if email.contains("@") && password.count >= 6 {
            completion(.success(true))
        } else {
            completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid signup data"])))
        }
    }
}
