//
//  SelectScenarioView.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/12/05.
//

import SwiftUI

// TODO ScenarioListView と SelectScenarioView はほぼ同じ構造、再利用できる方法にすること

struct SelectScenarioView: View {
    @Environment(\.dismiss) private var dismiss
    
    private var scenarios: [Scenario] = ScenarioSample.scenarios
    
    var body: some View {
        NavigationStack {
            List(scenarios) { scenario in
                NavigationLink(destination: ScenarioPhaseListView(phases: scenario.phases)) {
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
            .listStyle(.plain)
            .navigationTitle("シナリオを選択")
        }
    }
}

#Preview {
    SelectScenarioView()
}
