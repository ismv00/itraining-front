//
//  AddExerciseView.swift
//  iTraining
//
//  Created by Igor S. Menezes on 16/10/24.
//

import SwiftUI

struct AddExerciseView: View {
    
    let workout : Workout
    var onExerciseAdded: () -> Void
    
    @State private var exerciseName: String = ""
    @State private var sets: Int = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Novo Exercicio")) {
                    TextField("Nome do Exercicio", text: $exerciseName)
                    Stepper(value: $sets, in: 1...10) {
                        Text("Séries: \(sets)")
                    }
                }
                
                Button("Adicionar Exercicio") {
                    addExercise()
                }
                .disabled(exerciseName.isEmpty || sets == 0)
            }
            .navigationTitle("Adicionar Exercicio")
        }
    }
    
    func addExercise() {
        print("Exercicio \(exerciseName) com \(sets) séries adicionado ao treino")
        
        onExerciseAdded()
    }
}



#Preview {
    let exampleWorkout = Workout(id: 1, name: "Treino A", dayOfWeek: [1, 3, 5], exercises: nil, userId: 1)
    AddExerciseView(workout: exampleWorkout, onExerciseAdded: {
        
    })
}
