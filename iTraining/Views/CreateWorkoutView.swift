//
//  CreateWorkoutView.swift
//  iTraining
//
//  Created by Igor S. Menezes on 12/10/24.
//

import SwiftUI

struct CreateWorkoutView: View {
    
    @EnvironmentObject var userSession : UserSession
    @State private var name: String = ""
    @State private var selectedDays: Set<Int> = []
    @Environment(\.presentationMode) var presentationMode

    var onWorkoutCreated: () -> Void
    
    let workoutService = WorkoutService()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Detalhes do Treino")) {
                    TextField("Nome do treino", text: $name)
                }
                
                Section(header: Text("Dias da semana")) {
                    ForEach(0..<7, id: \.self) { day in
                        MultipleSelectionRow(day: day, isSelected: selectedDays.contains(day)) {
                            if selectedDays.contains(day) {
                                selectedDays.remove(day)
                            } else {
                                selectedDays.insert(day)
                            }
                        }
                    }
                }
                
                Button("Criar Treino") {
                    createWorkout()
                }
                .disabled(name.isEmpty || selectedDays.isEmpty) // Desabilita o botão se não houver nome ou dias selecionados
            }
            .navigationTitle("Criar novo treino")
        }
    }
    
    func createWorkout() {
        
        let userId = userSession.userId
        let token = userSession.token
        
        workoutService.createWorkout(userId: userId, token: token, name: name, days: Array(selectedDays)) { result in
            switch result {
            case .success(let workout):
                print("Workout created: \(workout)")
                DispatchQueue.main.async {
                    onWorkoutCreated()
                    
                    //Fechar a tela e voltar para a HomeView
                    self.presentationMode.wrappedValue.dismiss()
                }
            case .failure(let error):
                print("Error creating workout: \(error)")
            }
        }
    }
}

struct MultipleSelectionRow: View {
    var day: Int
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Text(dayOfWeekName(for: day))
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
    
    func dayOfWeekName(for index: Int) -> String {
        let weekDays = ["Domingo", "Segunda-feira", "Terça-feira", "Quarta-feira",  "Quinta-feira", "Sexta-feira", "Sábado"]
        return weekDays[index]
    }
}

#Preview {
    CreateWorkoutView(onWorkoutCreated: {})
        .environmentObject(UserSession())
}
