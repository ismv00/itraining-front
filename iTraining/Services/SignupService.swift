//
//  SignupService.swift
//  iTraining
//
//  Created by Igor S. Menezes on 09/10/24.
//

import Foundation


struct SignupService {
    func signup(name: String, email: String, password: String, completion: @escaping(Result<Void, APIError>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/users/register") else {
            completion(.failure(APIError(error: "Invalid URL")))
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
                completion(.failure(APIError(error: error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError(error: "Invalid Response.")))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                if let data = data, let errorResponse = try? JSONDecoder().decode(APIError.self, from: data) {
                    completion(.failure(errorResponse))
                } else {
                    completion(.failure(APIError(error: "Unexpected server errror.")))
                }
                return
            }
            
            completion(.success(()))
        }
        
        task.resume()
    }
    
   
}


