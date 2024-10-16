//
//  WorkoutService.swift
//  iTraining
//
//  Created by Igor S. Menezes on 10/10/24.
//

import Foundation

class WorkoutService {
    func fetchWorkout(userId: Int, token: String, completion: @escaping(Result<[Workout], Error>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/workouts/\(userId)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let workouts = try JSONDecoder().decode([Workout].self, from: data)
                completion(.success(workouts))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func createWorkout(userId: Int, token: String, name: String, days: [Int], completion: @escaping(Result<Workout, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/workouts/\(userId)") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let workoutData: [String: Any] = [
            "name": name,
            "dayOfWeek": days
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: workoutData, options: [])
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data , response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            
            do {
                let workout = try JSONDecoder().decode(Workout.self, from: data)
                completion(.success(workout))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
     }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "authToken")
    }
}
