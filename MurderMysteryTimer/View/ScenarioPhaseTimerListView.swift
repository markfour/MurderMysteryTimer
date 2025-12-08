//
//  ScenarioPhaseTimerListView.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/06/15.
//

import SwiftUI

struct ScenarioPhaseTimerListView: View {
    @State var scenario: Scenario? = nil
    
    @State private var timerModels: [PhaseTimerModel] = []
    @State private var isShowingScenarioSelection = false
    
    var body: some View {
        NavigationStack {
            Group {
                if scenario == nil {
                    ContentUnavailableView {
                        Button("シナリオを選択") {
                            isShowingScenarioSelection = true
                        }
                    }
                } else {
                    List(timerModels) { timerModel in
                        TimerRowView(
                            timerModel: timerModel,
                            onPlayButtonTap: { didTapPlayButton(for: timerModel) }
                        )
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(scenario?.title ?? "")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $isShowingScenarioSelection) {
            SelectScenarioView(selectedScenario: $scenario)
        }
        .onChange(of: scenario) { oldValue, newValue in
            if let newScenario = newValue {
                setupTimerModels(for: newScenario)
            } else {
                // シナリオがnilになった場合もクリア
                stopAllTimers()
                timerModels.removeAll()
                TimerDataManager.shared.timerItems = []
            }
        }
    }
    
    private func didTapPlayButton(for timerModel: PhaseTimerModel) {
        withAnimation(.none) {
            toggleTimer(for: timerModel)
        }
    }

    private func toggleTimer(for timerModel: PhaseTimerModel) {
        if timerModel.isRunning {
            timerModel.stop()
        } else {
            stopAllTimers()
            timerModel.start()
        }
    }
    
    private func stopAllTimers() {
        for timerModel in timerModels {
            timerModel.stop()
        }
    }
    
    private func setupTimerModels(for scenario: Scenario) {
        // 既存のタイマーをすべて停止してクリア
        stopAllTimers()
        timerModels.removeAll()
        
        // 各フェーズに対してタイマーモデルを作成
        for phase in scenario.phases {
            let model = PhaseTimerModel(seconds: phase.seconds, title: phase.title)
            timerModels.append(model)
        }
        
        // TimerDataManagerを更新
        TimerDataManager.shared.timerItems = scenario.phases
    }
}

struct TimerRowView: View {
    @ObservedObject var timerModel: PhaseTimerModel
    let onPlayButtonTap: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                TimerTextView(timerModel: timerModel)
                
                Text(timerModel.title)
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Button(action: onPlayButtonTap) {
                Image(systemName: timerModel.isRunning ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 44))
                    .foregroundColor(timerModel.isRunning ? .orange : .green)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct TimerTextView: View {
    @ObservedObject var timerModel: PhaseTimerModel
    
    var body: some View {
        Text(timerModel.formattedTime)
            .font(.headline)
    }
}

#Preview {
    ScenarioPhaseTimerListView()
}
