//
//  SelectScenarioView.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/12/05.
//

import SwiftUI

// ENHANCEMENT ScenarioListView と SelectScenarioView はほぼ同じ構造、再利用できる方法にすること

struct SelectScenarioView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedScenario: Scenario?

    private var scenarios: [Scenario] = ScenarioDataManager.shared.scenarios

    init(selectedScenario: Binding<Scenario?>) {
        self._selectedScenario = selectedScenario
    }

    var body: some View {
        NavigationStack {
            List(scenarios) { scenario in
                Button {
                    selectedScenario = scenario
                    dismiss()
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(scenario.title)
                            .font(.headline)
                            .foregroundStyle(.primary)
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
    @Previewable @State var selectedScenario: Scenario?
    SelectScenarioView(selectedScenario: $selectedScenario)
}
