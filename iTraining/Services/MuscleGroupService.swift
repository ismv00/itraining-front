//
//  MuscleGroupService.swift
//  iTraining
//
//  Created by Igor S. Menezes on 17/10/24.
//

import Foundation


class MuscleGroupService {
    func fecthMuscleGroup(completion: @escaping(Result<[MuscleGroup], Error>) -> Void) {
        let urlString = "http://localhost:3000/muscle/muscle-groups"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let muscleGroups = try JSONDecoder().decode([MuscleGroup].self, from: data)
                completion(.success(muscleGroups))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
