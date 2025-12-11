//
//  ScenarioPhaseDetailView.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/11/13.
//

import SwiftUI

struct ScenarioPhaseDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var phase: ScenarioPhase
    
    @State private var title: String = ""
    @State private var minutes: Int = 0
    
    init(phase: Binding<ScenarioPhase>) {
        self._phase = phase
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("タイトル") {
                    TextField("タイトル", text: $title)
                }
                
                Section("時間") {
                    HStack {
                        // 秒の項目を追加する
                        Text("分")
                        Spacer()
                        Picker("分", selection: $minutes) {
                            ForEach(0...59, id: \.self) { minute in
                                Text("\(minute)分").tag(minute)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 100)
                    }
                }
            }
            .navigationTitle("フェーズ編集")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("保存") {
                        saveChanges()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
        .onAppear {
            loadPhaseData()
        }
    }
    
    private func loadPhaseData() {
        title = phase.title
        minutes = phase.seconds / 60
    }
    
    private func saveChanges() {
        phase.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        phase.seconds = minutes * 60
        dismiss()
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
