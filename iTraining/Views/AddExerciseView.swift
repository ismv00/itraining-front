//
//  AddExerciseView.swift
//  iTraining
//
//  Created by Igor S. Menezes on 16/10/24.
//

import SwiftUI

struct AddExerciseView: View {
    @State private var selectedMuscleGroup: MuscleGroup? = nil
    @State private var exercises: [PredefinedExercise] = []
    @State private var selectedExercise: PredefinedExercise? = nil
    @State private var sets: String = ""
    @State private var reps: String = ""
    @State private var startWeight: String = ""
    @State private var endWeight: String = ""
    @State private var image: UIImage? = nil
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State private var muscleGroups: [MuscleGroup] = []
    private let muscleGroupService = MuscleGroupService()
    
    var body: some View {
        Form {
            Section(header: Text("Grupo Muscular")) {
                Picker("Grupo Muscular", selection: $selectedMuscleGroup) {
                    Text("Selecione um Grupo Muscular").tag(nil as MuscleGroup?)
                    ForEach(muscleGroups, id: \.id) { group in
                        Text(group.name).tag(group as MuscleGroup?)
                    }
                }
                .onChange(of: selectedMuscleGroup) { newValue in
                    
                    if newValue != nil {
                        fetchExercises(for: newValue)
                    }
                    
                }
            }
            
            Section(header: Text("Exercício")) {
                Picker("Exercício", selection: $selectedExercise) {
                    ForEach(exercises, id: \.id) { exercise in
                        Text(exercise.name).tag(exercise as PredefinedExercise?)
                    }
                }
            }
            
            Section(header: Text("Detalhes do Exercício")) {
                TextField("Séries", text: $sets)
                TextField("Repetições", text: $reps)
                TextField("Peso Inicial", text: $startWeight)
                TextField("Peso Final", text: $endWeight)
            }
            
            Section(header: Text("Imagem do Exercicio")) {
                if let selectedImage = image {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } else {
                    Text("Nenhuma imagem selecionada")
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                }
                
                HStack {
                    Button(action: {
                        sourceType = .photoLibrary
                        showImagePicker = true
                    }) {
                        Label("Galeria", systemImage: "photo.on.rectangle")
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(8)
                    
                    Button(action: {
                        sourceType = .camera
                        showImagePicker = true
                    }) {
                        Label("Tirar Foto", systemImage: "camera")
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundStyle(.white)
                    .cornerRadius(8)
                }
                
            }
            
            Button("Adicionar Exercício") {
                addExercise()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundStyle(.white)
            .cornerRadius(8)
        }
        .onAppear {
            fetchMuscleGroups()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $image, sourceType: sourceType)
        }
    }
    
    private func fetchMuscleGroups() {
        muscleGroupService.fecthMuscleGroup { result in
            switch result {
            case .success(let groups) :
                DispatchQueue.main.async {
                    self.muscleGroups = groups
                }
            case .failure(let error):
                print("Error fetching muscle groups: \(error)")
            }
        }
    }
    
    private func fetchExercises(for group: MuscleGroup?) {
        guard let group = group else { return }
        // Faça uma requisição para obter os exercícios com base no grupo selecionado
    }
    
    private func addExercise() {
        // Crie o exercício chamando o backend
    }
}





#Preview {
    let exampleWorkout = Workout(id: 1, name: "Treino A", dayOfWeek: [1,3,5], exercises: nil, userId: 1 )
    AddExerciseView()
}
