//
//  ScenarioPhaseListView.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/11/09.
//

import SwiftUI

struct ScenarioPhaseListView: View {
    @Binding var scenario: Scenario
    @State private var showingAddPhaseSheet = false
    @State private var newPhase: ScenarioPhase?
    
    var body: some View {
        List {
            ForEach($scenario.phases) { $phase in
                NavigationLink(destination: ScenarioPhaseDetailView(phase: $phase)) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(phase.totalTime)
                                .font(.headline)
                            Text(phase.title)
                                .font(.caption)
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
        .navigationTitle("フェーズ")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    createNewPhase()
                }) {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
        }
        .sheet(isPresented: $showingAddPhaseSheet) {
            if let newPhase = newPhase,
               let index = scenario.phases.firstIndex(where: { $0.id == newPhase.id }) {
                NavigationStack {
                    ScenarioPhaseDetailView(phase: $scenario.phases[index])
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("キャンセル") {
                                    cancelAddPhase()
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
    
    private func createNewPhase() {
        // 新しいIDを生成（既存の最大ID + 1）
        let newId = (scenario.phases.map(\.id).max() ?? 0) + 1
        
        // 新しいフェーズを作成
        let phase = ScenarioPhase(
            id: newId,
            title: "フェーズ",
            seconds: 600
        )
        
        // シナリオの最後に追加
        scenario.phases.append(phase)
        newPhase = phase
        
        // シートを表示
        showingAddPhaseSheet = true
    }
    
    private func cancelAddPhase() {
        // 追加したフェーズを削除
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
