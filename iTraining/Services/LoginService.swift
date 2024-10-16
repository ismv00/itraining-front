//
//  LoginService.swift
//  iTraining
//
//  Created by Igor S. Menezes on 09/10/24.
//

import Foundation

struct APIError: Decodable , Error {
    let error: String
}

struct loginResponse: Codable {
    let token: String
    let userId: Int
    let userName: String
}


class LoginService {
    func login(email: String, password: String, completion: @escaping (Result<(String, Int, String), APIError>) -> Void) {
            guard let url = URL(string: "http://localhost:3000/users/login") else {
                completion(.failure(APIError(error: "URL inválida.")))
                return
            }
        
        var request = URLRequest(url: url)
        request.httpMethod =  "POST"
        let body = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(APIError(error: error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError(error: "Dados não recebidos.")))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                //Docodifica a resposta caso sucesso
                
                do {
                    let result = try JSONDecoder().decode(loginResponse.self, from: data)
                    completion(.success((result.token, result.userId, result.userName)))
                } catch {
                    completion(.failure(APIError(error: "Erro ao decodificar a resposta.")))
                }
            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                do {
                    let apiError = try JSONDecoder().decode(APIError.self, from: data)
                    completion(.failure(apiError))
                } catch {
                    completion(.failure(APIError(error: "Erro ao decodificar a mensagem de erro.")))
                }
            } else {
                completion(.failure(APIError(error: "Erro desconhecido.")))
            }
        }
        
        task.resume()
    }
}
