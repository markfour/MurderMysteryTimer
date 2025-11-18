//
//  ScenarioListView.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/11/04.
//

import SwiftUI

struct ScenarioListView: View {
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
            .navigationTitle("ストーリー一覧")
        }
    }
}

#Preview {
    ScenarioListView()
}
