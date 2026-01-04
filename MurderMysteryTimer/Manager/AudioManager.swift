//
//  AudioManager.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/12/09.
//

import Foundation
import AVFoundation

@MainActor
final class AudioManager {
    static let shared = AudioManager()
    
    private var audioPlayer: AVAudioPlayer?
    private var soundTask: Task<Void, Never>?
    
    private init() {
        setupAudioPlayer()
    }
    
    func didEndPhaseSound(duration: TimeInterval = 3.0) {
        soundTask?.cancel()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("AVAudioSessionの設定に失敗しました: \(error)")
        }
        
        if let player = audioPlayer {
            player.currentTime = 0
            player.numberOfLoops = -1
            player.play()
            
            soundTask = Task {
                try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
                if !Task.isCancelled {
                    await MainActor.run {
                        player.stop()
                        player.currentTime = 0
                        player.numberOfLoops = 0
                    }
                }
            }
        } else {
            playSystemSound(duration: duration)
        }
    }
    
    private func setupAudioPlayer() {
        let soundPath = "/System/Library/Audio/UISounds/alarm.caf"
        let soundURL = URL(fileURLWithPath: soundPath)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
        } catch {
            if let customSoundURL = Bundle.main.url(forResource: "alarm", withExtension: "mp3") {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: customSoundURL)
                    audioPlayer?.prepareToPlay()
                } catch {
                    print("オーディオプレイヤーのセットアップに失敗しました: \(error)")
                }
            }
        }
    }

    private func playSystemSound(duration: TimeInterval) {
        let soundID: SystemSoundID = 1005
        
        soundTask = Task {
            let repeatCount = Int(duration / 0.5)
            for _ in 0..<repeatCount {
                if Task.isCancelled { break }
                AudioServicesPlaySystemSound(soundID)
                try? await Task.sleep(nanoseconds: 500_000_000)
            }
        }
    }
}
