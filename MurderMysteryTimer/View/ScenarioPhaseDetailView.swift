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
    @State private var seconds: Int = 0
    @State private var timeUnit: TimeUnit = .minutes
    
    enum TimeUnit: String, CaseIterable {
        case minutes = "分"
        case seconds = "秒"
    }
    
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
                Picker("単位", selection: $timeUnit) {
                    ForEach(TimeUnit.allCases, id: \.self) { unit in
                        Text(unit.rawValue).tag(unit)
                    }
                }
                .pickerStyle(.segmented)
                
                HStack {
                    Text(timeUnit.rawValue)
                    Spacer()
                    
                    // TODO レイアウト調整、数値 分、中央寄せが良い
                    if timeUnit == .minutes {
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
                    } else {
                        Picker("秒", selection: $seconds) {
                            ForEach(0...59, id: \.self) { second in
                                Text("\(second)秒").tag(second)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 100)
                        .onChange(of: seconds) { oldValue, newValue in
                            saveChanges()
                        }
                    }
                }
            }
        }
        .navigationTitle("フェーズ編集")
        .onAppear {
            loadPhaseData()
        }
    }
    
    private func loadPhaseData() {
        title = phase.title
        
        // 既存の秒数から分と秒を計算
        let totalSeconds = phase.seconds
        minutes = totalSeconds / 60
        seconds = totalSeconds
        
        // 60秒以上なら分モード、未満なら秒モード
        timeUnit = totalSeconds >= 60 ? .minutes : .seconds
    }
    
    private func saveChanges() {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedTitle.isEmpty {
            phase.title = trimmedTitle
            
            if timeUnit == .minutes {
                phase.seconds = minutes * 60
            } else {
                phase.seconds = seconds
            }
            
            ScenarioDataManager.shared.saveScenarios()
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
