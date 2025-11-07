//
//  ScenarioListView.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/11/04.
//

import SwiftUI

struct ScenarioListView: View {
    @Environment(\.dismiss) private var dismiss
    
    private var scenarios: [Scenario] = [
        Scenario(id: 1, title: "ストーリー1", phases: []),
        Scenario(id: 2, title: "ストーリー2", phases: []),
        Scenario(id: 3, title: "ストーリー3", phases: [])
    ]
    
    var body: some View {
        NavigationStack {
            List(scenarios) { scenario in
                Text(scenario.title)
            }
            .navigationTitle("ストーリー一覧")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("閉じる") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ScenarioListView()
}
