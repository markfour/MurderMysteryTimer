//
//  TimerModel.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/07/22.
//

import Foundation
import SwiftUI
import AVFoundation
internal import Combine

@MainActor
final class PhaseTimerModel: ObservableObject, Identifiable {
    let id = UUID()
    @Published var remainingSeconds: Int
    @Published var isRunning = false
    @Published var isBlinking = false
    @Published var isCompleted = false
    let title: String
    let initialSeconds: Int

    private var task: Task<Void, Never>?
    private var blinkTask: Task<Void, Never>?
    private var audioPlayer: AVAudioPlayer?

    init(seconds: Int, title: String) {
        self.remainingSeconds = seconds
        self.initialSeconds = seconds
        self.title = title
        setupAudioPlayer()
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
                
                // 残り60秒以下になったらブリンクを開始
                if remainingSeconds <= 60 && remainingSeconds > 0 {
                    await startBlinking()
                }
            }
            // タイマー終了時の状態更新
            await MainActor.run {
                isRunning = false
                if remainingSeconds <= 0 {
                    isCompleted = true
                    playCompletionSound()
                }
                stopBlinking()
            }
        }
    }

    func stop() {
        isRunning = false
        task?.cancel()
        task = nil
        stopBlinking()
    }
    
    private func startBlinking() async {
        guard blinkTask == nil else { return }
        
        blinkTask = Task {
            while !Task.isCancelled && isRunning && remainingSeconds > 0 {
                await MainActor.run {
                    isBlinking.toggle()
                }
                try? await Task.sleep(nanoseconds: 500_000_000) // 0.5秒間隔
            }
        }
    }
    
    private func stopBlinking() {
        blinkTask?.cancel()
        blinkTask = nil
        isBlinking = false
    }
    
    private func setupAudioPlayer() {
        // システムのアラームサウンドを使用
        let soundPath = "/System/Library/Audio/UISounds/alarm.caf"
        let soundURL = URL(fileURLWithPath: soundPath)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.numberOfLoops = -1 // 無限ループ
            audioPlayer?.prepareToPlay()
        } catch {
            // システムサウンドが見つからない場合は、カスタムサウンドを試す
            if let customSoundURL = Bundle.main.url(forResource: "alarm", withExtension: "mp3") {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: customSoundURL)
                    audioPlayer?.numberOfLoops = -1
                    audioPlayer?.prepareToPlay()
                } catch {
                    print("オーディオプレイヤーのセットアップに失敗しました: \(error)")
                }
            }
        }
    }
    
    private func playCompletionSound() {
        // AVAudioSessionの設定（サイレントモードでも再生）
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("AVAudioSessionの設定に失敗しました: \(error)")
        }
        
        // サウンドを再生
        if let player = audioPlayer {
            player.currentTime = 0
            player.play()
            
            // 3秒後に停止
            Task {
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                await MainActor.run {
                    player.stop()
                    player.currentTime = 0
                }
            }
        } else {
            // フォールバック: システムサウンドを使用
            playSystemSound()
        }
    }
    
    private func playSystemSound() {
        // システムサウンドIDを使用（アラーム音）
        let soundID: SystemSoundID = 1005 // システムアラーム音
        AudioServicesPlaySystemSound(soundID)
        
        // 3秒間繰り返し再生
        Task {
            for _ in 0..<6 { // 0.5秒間隔で6回 = 3秒
                AudioServicesPlaySystemSound(soundID)
                try? await Task.sleep(nanoseconds: 500_000_000)
            }
        }
    }
}

