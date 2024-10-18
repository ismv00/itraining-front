//
//  PredefinedExerciseService.swift
//  iTraining
//
//  Created by Igor S. Menezes on 17/10/24.
//

import Foundation

class PredefinedExerciseService {
    func fetchPredefinedExercises(for muscleGroupId: Int, completion: @escaping (Result<[PredefinedExercise], Error>) -> Void) {
        
        let urlString = "http://localhost:3000/muscle-groups/\(muscleGroupId)/exercises"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let exercises = try JSONDecoder().decode([PredefinedExercise].self, from: data)
                completion(.success(exercises))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
