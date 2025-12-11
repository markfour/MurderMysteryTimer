//
//  ScenarioPhaseDetailView.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/11/13.
//

import SwiftUI

struct ScenarioPhaseDetailView: View {
    @Binding var phase: ScenarioPhase
    
    @State private var title: String = ""
    @State private var minutes: Int = 0
    
    init(phase: Binding<ScenarioPhase>) {
        self._phase = phase
    }

    var body: some View {
        Form {
            Section("タイトル") {
                TextField("タイトル", text: $title)
                    .onChange(of: title) { oldValue, newValue in
                        saveChanges()
                    }
            }
            
            Section("時間") {
                HStack {
                    // TODO 秒の項目を追加する
                    Text("分")
                    Spacer()
                    Picker("分", selection: $minutes) {
                        ForEach(0...59, id: \.self) { minute in
                            Text("\(minute)分").tag(minute)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 100)
                    .onChange(of: minutes) { oldValue, newValue in
                        saveChanges()
                    }
                }
            }
        }
        .navigationTitle("フェーズ編集")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadPhaseData()
        }
    }
    
    private func loadPhaseData() {
        title = phase.title
        minutes = phase.seconds / 60
    }
    
    private func saveChanges() {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedTitle.isEmpty {
            phase.title = trimmedTitle
            phase.seconds = minutes * 60
        }
    }
}

#Preview {
    @Previewable @State var phase = ScenarioPhase(
        id: 1,
        title: "導入フェーズ",
        seconds: 300
    )
    
    ScenarioPhaseDetailView(phase: $phase)
}
