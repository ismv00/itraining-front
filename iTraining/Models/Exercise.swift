//
//  Exercise.swift
//  iTraining
//
//  Created by Igor S. Menezes on 10/10/24.
//

import Foundation

struct Exercise: Identifiable, Codable {
    let id: Int
    let name: String
    let sets: Int
    let reps: Int
    let startWeight: Float
    let endWeight: Float
    let image: String?
    let workoutId: Int
    let userId: Int
}
