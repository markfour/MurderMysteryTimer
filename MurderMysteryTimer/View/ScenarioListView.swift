//
//  ScenarioListView.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/11/04.
//

import SwiftUI

struct ScenarioListView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var dataManager = ScenarioDataManager.shared
    
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
            .listStyle(.plain)
            .navigationTitle("シナリオ")
        }
    }
}

#Preview {
    ScenarioListView()
}
