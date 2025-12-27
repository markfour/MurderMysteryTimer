//
//  ScenarioPhaseListView.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/11/09.
//

import SwiftUI

struct ScenarioPhaseListView: View {
    @Binding var scenario: Scenario
    @Environment(\.editMode) private var editMode
    @State private var showingAddPhaseSheet = false
    @State private var newPhase: ScenarioPhase?

    var body: some View {
        List {
            ForEach($scenario.phases) { $phase in
                NavigationLink(destination: ScenarioPhaseDetailView(mode: .edit, phase: $phase)) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(phase.title)
                                .font(.headline)
                            Text(phase.totalTime)
                                .font(.body)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
            }
            .onMove(perform: movePhase)
        }
        .listStyle(.plain)
        .navigationTitle(scenario.title)
        .onChange(of: scenario) { oldValue, newValue in
            ScenarioDataManager.shared.updateScenario(newValue)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    addNewPhase()
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
        .sheet(isPresented: $showingAddPhaseSheet) {
            if let newPhase = newPhase,
               let index = scenario.phases.firstIndex(where: { $0.id == newPhase.id }) {
                NavigationStack {
                    ScenarioPhaseDetailView(mode: .add, phase: $scenario.phases[index])
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("キャンセル") {
                                    cancelAddNewPhase()
                                }
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("保存") {
                                    showingAddPhaseSheet = false
                                }
                            }
                        }
                }
            }
        }
    }

    private func movePhase(from source: IndexSet, to destination: Int) {
        scenario.phases.move(fromOffsets: source, toOffset: destination)
    }

    private func addNewPhase() {
        let newId = (scenario.phases.map(\.id).max() ?? 0) + 1

        let phase = ScenarioPhase(
            id: newId,
            title: "フェーズ",
            seconds: 600
        )

        scenario.phases.append(phase)
        newPhase = phase

        showingAddPhaseSheet = true
    }

    private func cancelAddNewPhase() {
        if let newPhase = newPhase {
            scenario.phases.removeAll { $0.id == newPhase.id }
        }
        showingAddPhaseSheet = false
        self.newPhase = nil
    }
}

#Preview {
    @Previewable @State var sampleScenario = Scenario(
        id: 1,
        title: "サンプルシナリオ",
        phases: [
            ScenarioPhase(id: 1, title: "導入フェーズ", seconds: 300),
            ScenarioPhase(id: 2, title: "調査フェーズ", seconds: 600),
            ScenarioPhase(id: 3, title: "推理フェーズ", seconds: 900),
            ScenarioPhase(id: 4, title: "解決フェーズ", seconds: 300)
        ]
    )

    NavigationStack {
        ScenarioPhaseListView(scenario: $sampleScenario)
    }
}
