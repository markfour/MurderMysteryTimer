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
    
    var body: some View {
        NavigationStack {
            Form {
                Section("フェーズ情報") {
                    TextField("タイトル", text: $title)
                }
                
                Section("時間設定") {
                    HStack {
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
                
                Section("プレビュー") {
                    HStack {
                        Text("合計時間:")
                        Spacer()
                        Text("\(minutes)分")
                            .font(.headline)
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
    @Previewable @State var samplePhase = ScenarioPhase(
        id: 1,
        seconds: 300,
        subtitle: "導入フェーズ"
    )
    
    ScenarioPhaseDetailView(phase: $samplePhase)
}
