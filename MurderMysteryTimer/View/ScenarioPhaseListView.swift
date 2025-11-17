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
            .navigationTitle("フェーズ一覧")
        }
    }
    
    private func togglePhaseStatus(for phaseId: Int) {
        if let index = scenarioPhases.firstIndex(where: { $0.id == phaseId }) {
            for i in scenarioPhases.indices {
                scenarioPhases[i].status = .stop
            }
            
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
