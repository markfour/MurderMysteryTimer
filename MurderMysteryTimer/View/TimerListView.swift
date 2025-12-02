//
//  TimerListView.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/06/15.
//

import SwiftUI

struct TimerListView: View {
    @State private var timerModels: [Int: TimerModel] = TimerDataManager.shared.createTimerModels()
    
    var body: some View {
        NavigationStack {
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
            .navigationTitle("マーダーミステリータイマー")
            .navigationBarTitleDisplayMode(.inline)
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
}

struct TimerRowView: View {
    let item: ScenarioPhase
    @ObservedObject var timerModel: TimerModel
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
                Text(timerModel.isRunning ? "⏸️" : "▶️")
                    .font(.title2)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct TimerTextView: View {
    @ObservedObject var timerModel: TimerModel
    
    var body: some View {
        Text(timerModel.formattedTime)
            .font(.headline)
    }
}

#Preview {
    TimerListView()
}