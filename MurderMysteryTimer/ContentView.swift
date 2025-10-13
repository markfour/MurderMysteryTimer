//
//  ContentView.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/06/15.
//

import SwiftUI

struct ContentView: View {
    @State private var timerModels: [Int: TimerModel] = [:]
    
    var body: some View {
        List(sampleData) { item in
            if let timerModel = timerModels[item.id] {
                TimerRowView(
                    item: item,
                    timerModel: timerModel,
                    onPlayButtonTap: { didTapPlayButton(for: item) }
                )
            } else {
                DefaultRowView(
                    item: item,
                    onPlayButtonTap: { didTapPlayButton(for: item) }
                )
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private func didTapPlayButton(for item: ListItem) {
        withAnimation(.none) {
            toggleTimer(for: item)
        }
    }

    private func toggleTimer(for item: ListItem) {
        if let timerModel = timerModels[item.id] {
            if timerModel.isRunning {
                // タイマーを停止
                timerModel.stop()
            } else {
                // 他のすべてのタイマーを停止してから開始
                stopAllTimers()
                timerModel.start()
            }
        } else {
            // 新しいタイマーを作成
            stopAllTimers()
            let newTimer = TimerModel(seconds: item.seconds, title: item.subtitle)
            timerModels[item.id] = newTimer
            newTimer.start()
        }
    }
    
    private func stopAllTimers() {
        for timerModel in timerModels.values {
            timerModel.stop()
        }
    }
}

struct TimerRowView: View {
    let item: ListItem
    @ObservedObject var timerModel: TimerModel
    let onPlayButtonTap: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                TimerTextView(timerModel: timerModel)
                
                Text(item.subtitle)
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

struct DefaultRowView: View {
    let item: ListItem
    let onPlayButtonTap: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                
                Text(item.subtitle)
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Button(action: onPlayButtonTap) {
                Text("▶️")
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


struct ListItem: Identifiable {
    enum status {
        case playing
        case stop
    }
    
    var id: Int
    var seconds: Int
    var subtitle: String
    var status: status = .stop
    
    var title: String {
        seconds.toMinuteSecondString
    }
}

let sampleData = [
    ListItem(id: 1, seconds: 900, subtitle: "キャラクターシート読み込み"),
    ListItem(id: 2, seconds: 1200, subtitle: "第一捜査"),
    ListItem(id: 3, seconds: 900, subtitle: "第一推理"),
    ListItem(id: 4, seconds: 1200, subtitle: "第二捜査"),
    ListItem(id: 5, seconds: 900, subtitle: "第二推理"),
    ListItem(id: 6, seconds: 300, subtitle: "投票"),
    ListItem(id: 7, seconds: 300, subtitle: "アクション"),
    ListItem(id: 8, seconds: 900, subtitle: "エンディング"),
    
]

#Preview {
    ContentView()
}
