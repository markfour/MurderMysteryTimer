//
//  TimerModel.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/07/22.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
final class TimerModel: ObservableObject, Identifiable {
    let id = UUID()
    @Published var remainingSeconds: Int
    @Published var isRunning = false
    @Published var isBlinking = false
    @Published var isCompleted = false
    let title: String
    let initialSeconds: Int

    private var task: Task<Void, Never>?
    private var blinkTask: Task<Void, Never>?

    init(seconds: Int, title: String) {
        self.remainingSeconds = seconds
        self.initialSeconds = seconds
        self.title = title
    }

    var formattedTime: String {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func start() {
        guard !isRunning else { return }
        
        // 状態を即座に更新
        isRunning = true
        isCompleted = false
        
        // タイマータスク
        task = Task {
            while remainingSeconds > 0 && !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                remainingSeconds -= 1
            }
            // タイマー終了時の状態更新
            await MainActor.run {
                isRunning = false
                if remainingSeconds <= 0 {
                    isCompleted = true
                }
            }
        }
    }

    func stop() {
        isRunning = false
        task?.cancel()
        task = nil
    }
}

