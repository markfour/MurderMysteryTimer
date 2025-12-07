//
//  ScenarioPhaseTimerListView.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/06/15.
//

import SwiftUI

struct ScenarioPhaseTimerListView: View {
    @State var scenario: Scenario? = nil
    
    @State private var timerModels: [Int: PhaseTimerModel] = [:]
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
                    List(TimerDataManager.shared.timerItems) { item in
                        if let timerModel = timerModels[item.id] {
                            TimerRowView(
                                item: item,
                                timerModel: timerModel,
                                onPlayButtonTap: { didTapPlayButton(for: item) }
                            )
                        }
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
            }
        }
    }
    
    private func didTapPlayButton(for item: ScenarioPhase) {
        withAnimation(.none) {
            toggleTimer(for: item)
        }
    }

    private func toggleTimer(for item: ScenarioPhase) {
        guard let timerModel = timerModels[item.id] else { return }
        
        if timerModel.isRunning {
            timerModel.stop()
        } else {
            stopAllTimers()
            timerModel.start()
        }
    }
    
    private func stopAllTimers() {
        for timerModel in timerModels.values {
            timerModel.stop()
        }
    }
    
    private func setupTimerModels(for scenario: Scenario) {
        timerModels.removeAll()
        for phase in scenario.phases {
            timerModels[phase.id] = PhaseTimerModel(seconds: phase.seconds, title: phase.title)
        }
        TimerDataManager.shared.timerItems = scenario.phases
    }
}

struct TimerRowView: View {
    let item: ScenarioPhase
    @ObservedObject var timerModel: PhaseTimerModel
    let onPlayButtonTap: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                TimerTextView(timerModel: timerModel)
                
                Text(item.title)
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
