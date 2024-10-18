//
//  PredefinedExercise.swift
//  iTraining
//
//  Created by Igor S. Menezes on 17/10/24.
//

import Foundation


struct PredefinedExercise: Identifiable, Hashable, Decodable, Encodable {
    let id: Int
    let name: String
    let muscleGroupId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case muscleGroupId = "muscleGroupId"
    }
}
