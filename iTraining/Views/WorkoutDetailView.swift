//
//  WorkoutDetailView.swift
//  iTraining
//
//  Created by Igor S. Menezes on 16/10/24.
//

import SwiftUI

struct WorkoutDetailView: View {
    let workout : Workout
    @State private var exercises: [Exercise] = []
    @EnvironmentObject var userSession : UserSession
    @State private var showingAddExerciseView = false
    
    var body: some View {
        VStack {
            Text("treino: \(workout.name)")
                .font(.largeTitle)
                .padding()
            
            List(exercises) {exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name)
                        .font(.headline)
                    Text("Series: \(exercise.sets)")
                        .font(.subheadline)
                }
            }
            .onAppear {
                loadExercises()
            }
            
            Button(action: {
                showingAddExerciseView.toggle()
            }) {
                HStack{
                    Image(systemName: "plus")
                    Text("Adicionar Exercicio")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundStyle(.white)
                .cornerRadius(10)
                .padding(.horizontal, 60)
            }
        }
        .sheet(isPresented: $showingAddExerciseView) {
            AddExerciseView(workout: workout) {
                loadExercises()
            }
        }
    }
        
        func loadExercises() {
            exercises = [
                Exercise(id: 1, name: "Agachamento", sets: 4, reps: 12, startWeight: 20, endWeight: 100, image: nil, workoutId: 1, userId: 1)
            ]
        }
    }


#Preview {
    let exampleWorkout = Workout(id: 1, name: "Treino A", dayOfWeek: [1, 3, 5], exercises: nil, userId: 1)
    WorkoutDetailView(workout: exampleWorkout)
}
