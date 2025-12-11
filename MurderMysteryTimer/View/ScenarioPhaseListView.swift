//
//  ScenarioPhaseListView.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/11/09.
//

import SwiftUI

struct ScenarioPhaseListView: View {
    @State private var phases: [ScenarioPhase]
    
    init(phases: [ScenarioPhase]) {
        self.phases = phases
    }
    
    var body: some View {
        NavigationStack {
            List(phases) { phase in
                NavigationLink(destination: ScenarioPhaseDetailView(phase: .constant(phase))) {
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
            .listStyle(.plain)
            .navigationTitle("フェーズ")
        }
    }
}

#Preview {
    let samplePhases = [
        ScenarioPhase(id: 1, title: "導入フェーズ", seconds: 300),
        ScenarioPhase(id: 2, title: "調査フェーズ", seconds: 600),
        ScenarioPhase(id: 3, title: "推理フェーズ", seconds: 900),
        ScenarioPhase(id: 4, title: "解決フェーズ", seconds: 300)
    ]
    
    ScenarioPhaseListView(phases: samplePhases)
}
