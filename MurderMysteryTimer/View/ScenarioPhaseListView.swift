//
//  ScenarioPhaseListView.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/11/09.
//

import SwiftUI

struct ScenarioPhaseListView: View {
    @Binding var scenario: Scenario
    
    var body: some View {
        List($scenario.phases) { $phase in
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
        .listStyle(.plain)
        .navigationTitle("フェーズ")
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
