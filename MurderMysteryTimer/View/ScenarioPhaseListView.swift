//
//  ScenarioPhaseListView.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/11/09.
//

import SwiftUI

struct ScenarioPhaseListView: View {
    let phases: [ScenarioPhase]
    @State private var scenarioPhases: [ScenarioPhase]
    
    init(phases: [ScenarioPhase]) {
        self.phases = phases
        self._scenarioPhases = State(initialValue: phases)
    }
    
    var body: some View {
        NavigationStack {
            List($scenarioPhases) { $phase in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(phase.title)
                            .font(.headline)
                        Text(phase.subtitle)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        togglePhaseStatus(for: phase.id)
                    }) {
                        Image(systemName: phase.status == .playing ? "pause.circle.fill" : "play.circle.fill")
                            .font(.title2)
                            .foregroundColor(phase.status == .playing ? .red : .green)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("フェーズ一覧")
        }
    }
    
    private func togglePhaseStatus(for phaseId: Int) {
        if let index = scenarioPhases.firstIndex(where: { $0.id == phaseId }) {
            // すべてのフェーズを停止状態にする
            for i in scenarioPhases.indices {
                scenarioPhases[i].status = .stop
            }
            
            // 選択されたフェーズのステータスを切り替える
            if scenarioPhases[index].status == .stop {
                scenarioPhases[index].status = .playing
            }
        }
    }
}

#Preview {
    let samplePhases = [
        ScenarioPhase(id: 1, seconds: 300, subtitle: "導入フェーズ"),
        ScenarioPhase(id: 2, seconds: 600, subtitle: "調査フェーズ"),
        ScenarioPhase(id: 3, seconds: 900, subtitle: "推理フェーズ"),
        ScenarioPhase(id: 4, seconds: 300, subtitle: "解決フェーズ")
    ]
    
    ScenarioPhaseListView(phases: samplePhases)
}