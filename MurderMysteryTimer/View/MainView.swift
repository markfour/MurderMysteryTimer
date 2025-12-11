//
//  MainView.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/06/15.
//

import SwiftUI

struct MainView: View {
    @State var scenario: Scenario? = nil
    
    @State private var phaseTimers: [PhaseTimer] = []
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
                    timerListView
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
                phaseTimers.removeAll()
                TimerDataManager.shared.timerItems = []
            }
        }
    }
    
    @ViewBuilder
    private var timerListView: some View {
        List(phaseTimers) { timerModel in
            MainListRowSwitch(timerModel: timerModel, onPlayButtonTap: {
                didTapPlayButton(for: timerModel)
            })
        }
        .listStyle(.plain)
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
        for timerModel in phaseTimers {
            timerModel.stop()
        }
    }
    
    private func setupTimerModels(for scenario: Scenario) {
        stopAllTimers()
        phaseTimers.removeAll()
        
        for phase in scenario.phases {
            let model = PhaseTimer(seconds: phase.seconds, title: phase.title)
            phaseTimers.append(model)
        }
        
        TimerDataManager.shared.timerItems = scenario.phases
    }
}

private struct MainListRowSwitch: View {
    @ObservedObject var timerModel: PhaseTimer
    let onPlayButtonTap: () -> Void
    
    var body: some View {
        if timerModel.isRunning {
            MainListActiveRow(
                phaseTimer: timerModel,
                onPlayButtonTap: onPlayButtonTap
            )
        } else {
            MainListRow(
                phaseTimer: timerModel,
                onPlayButtonTap: onPlayButtonTap
            )
        }
    }
}

#Preview {
    MainView()
}
