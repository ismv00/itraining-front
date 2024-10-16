//
//  SignupService.swift
//  iTraining
//
//  Created by Igor S. Menezes on 09/10/24.
//

import Foundation

struct SignupService {
    func signup(name: String, email: String, password: String, completion: @escaping(Result<Void, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/users/register") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "name" : name,
            "email" : email,
            "password": password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid response", code: 400, userInfo: nil)))
                return
            }
            
            completion(.success(()))
        }
        
        task.resume()
    }
    
   
}


