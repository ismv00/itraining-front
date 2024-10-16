//
//  HomeView.swift
//  iTraining
//
//  Created by Igor S. Menezes on 09/10/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userSession : UserSession
    @State private var NavigateToLogin = false
    @State private var workouts: [Workout] = []
    let userId : Int
    let token: String
    let userName: String
    @State private var showingCreateWorkoutView = false
    
    let signupService = SignupService()
    let workoutService = WorkoutService()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Olá, \(userSession.userName)")
                    .font(.title)
                    .foregroundStyle(.blue)
                    .padding()
                
                
                List {
                    ForEach(workouts) { workout in
                        
                        NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                            VStack(alignment: .leading) {
                                Text(workout.name)
                                    .font(.headline)
                                Text("Dias: \(workout.daysOfWeekAsString().joined(separator: ", "))")
                                    .font(.subheadline)
                            }
                            .padding(.vertical, 20)
                        }
                        
                    }
                    .onDelete(perform: deleteWorkout)
                }
                .onAppear {
                    loadWorkouts()
                }
                
                Button(action: {
                    showingCreateWorkoutView.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Criar Treino")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 60)
                }
                
                //Button de logout
                Button(action: {
                    handleLogout()
                }) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left")
                        Text("Sair")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 60)
                    
                }
            }
            .navigationTitle("")
            .overlay(
                NavigationLink(destination: LoginView(), isActive: $NavigateToLogin) {
                    EmptyView()
                }
            )
            .sheet(isPresented: $showingCreateWorkoutView) {
                CreateWorkoutView {
                    loadWorkouts()
                }
                .environmentObject(userSession)
                        }
        }
    }
    
    func loadWorkouts() {
        workoutService.fetchWorkout(userId: userSession.userId, token: userSession.token) {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedWorkouts) :
                    workouts = fetchedWorkouts
                case .failure(let error):
                    print("Error fetching workouts: \(error)")
                }
            }
        }
    }
    
    func deleteWorkout(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        
        let workout = workouts[index]
        
        workoutService.deleteWorkout(userId: userSession.userId, workoutId: workout.id, token: userSession.token) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    workouts.remove(atOffsets: offsets)
                case .failure(let error):
                    print("Error deleting Workout: \(error)")
                }
            }
        }
    }
    
    func handleLogout() {
        workoutService.logout()
        NavigateToLogin = true
    }
}


    

#Preview {
    HomeView(userId: 1, token: "sampleToken", userName: "John Doe")
        .environmentObject(UserSession())
}

