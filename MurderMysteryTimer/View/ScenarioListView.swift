//
//  ScenarioListView.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/11/04.
//

import SwiftUI

struct ScenarioListView: View {
    @Environment(\.dismiss) private var dismiss // TODO 使われている?
    @Environment(\.editMode) private var editMode
    @StateObject private var dataManager = ScenarioDataManager.shared
    
    @State private var showingAddScenarioAlert = false
    @State private var newScenarioTitle = ""
    
    var body: some View {
        NavigationStack {
            List($dataManager.scenarios) { $scenario in
                NavigationLink(destination: ScenarioPhaseListView(scenario: $scenario)) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(scenario.title)
                            .font(.headline)
                        Text("合計時間 \(scenario.phases.map(\.seconds).reduce(0, +).toHourMinuteString)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 2)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        createSenario()
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(editMode?.wrappedValue == .active ? "完了" : "編集") {
                        withAnimation {
                            if editMode?.wrappedValue == .active {
                                editMode?.wrappedValue = .inactive
                            } else {
                                editMode?.wrappedValue = .active
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("シナリオ")
            .alert("シナリオを追加", isPresented: $showingAddScenarioAlert) {
                TextField("タイトル", text: $newScenarioTitle)
                Button("キャンセル", role: .cancel) {
                    cancelCreateSenario()
                }
                Button("追加") {
                    addNewScenario()
                }
                .disabled(newScenarioTitle.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
    }
    
    private func createSenario() {
        newScenarioTitle = ""
        showingAddScenarioAlert = true
    }
    
    private func addNewScenario() {
        guard !newScenarioTitle.isEmpty else { return }
        
        let newId = dataManager.generateNewScenarioId()
        
        let newScenario = Scenario(
            id: newId,
            title: newScenarioTitle,
            phases: []
        )
        
        dataManager.addScenario(newScenario)
        
        newScenarioTitle = ""
    }
    
    private func cancelCreateSenario() {
        newScenarioTitle = ""
    }
}

#Preview {
    ScenarioListView()
}
