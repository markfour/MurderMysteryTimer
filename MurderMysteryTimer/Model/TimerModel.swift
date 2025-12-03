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
    @Published var remainingSeconds: Int {
        didSet {
            // remainingSecondsが変更された時にinitialSecondsも更新
            if !isRunning {
                initialSeconds = remainingSeconds
            }
        }
    }
    @Published var isRunning = false
    @Published var isBlinking = false
    @Published var isCompleted = false
    let title: String
    private(set) var initialSeconds: Int

    private var timer: Timer?
    private var blinkTimer: Timer?

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
        
        isRunning = true
        isCompleted = false
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            self.remainingSeconds -= 1
            
            // 残り60秒以下になったらブリンクを開始
            if self.remainingSeconds <= 60 && self.remainingSeconds > 0 {
                self.startBlinking()
            }
            
            // タイマー終了時の処理
            if self.remainingSeconds <= 0 {
                self.stop()
                self.isCompleted = true
            }
        }
    }

    func stop() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        stopBlinking()
    }
    
    private func startBlinking() {
        guard blinkTimer == nil else { return }
        
        blinkTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.isRunning && self.remainingSeconds > 0 {
                self.isBlinking.toggle()
            } else {
                self.stopBlinking()
            }
        }
    }
    
    private func stopBlinking() {
        blinkTimer?.invalidate()
        blinkTimer = nil
        isBlinking = false
    }
}

