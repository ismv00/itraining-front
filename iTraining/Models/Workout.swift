//
//  Workout.swift
//  iTraining
//
//  Created by Igor S. Menezes on 10/10/24.
//

import Foundation

struct Workout: Identifiable, Codable {
    let id : Int
    let name: String
    let dayOfWeek: [Int]
    let exercises: [Exercise]?
    let userId: Int
    
    func daysOfWeekAsString() -> [String] {
        let weekDays = ["Domingo", "Segunda-feira", "Terça-feira", "Quarta-feira", "Quinta-feira", "Sexta-feira", "Sábado"]
        return dayOfWeek.compactMap { index in
            index >= 0 && index < weekDays.count ? weekDays[index] : nil
        }
    }
}
