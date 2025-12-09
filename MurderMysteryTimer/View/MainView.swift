//
//  MainView.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/06/15.
//

import SwiftUI

struct MainView: View {
    @State var scenario: Scenario? = nil
    
    @State private var timerModels: [PhaseTimer] = []
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
                        MainListRow(
                            timerModel: timerModel,
                            onPlayButtonTap: { didTapPlayButton(for: timerModel) }
                        )
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(scenario?.title ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingScenarioSelection = true
                    } label: {
                        Image(systemName: "folder")
                    }
                }
            }
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
    
    private func didTapPlayButton(for timerModel: PhaseTimer) {
        withAnimation(.none) {
            toggleTimer(for: timerModel)
        }
    }

    private func toggleTimer(for timerModel: PhaseTimer) {
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
            let model = PhaseTimer(seconds: phase.seconds, title: phase.title)
            timerModels.append(model)
        }
        
        // TimerDataManagerを更新
        TimerDataManager.shared.timerItems = scenario.phases
    }
}

#Preview {
    MainView()
}
