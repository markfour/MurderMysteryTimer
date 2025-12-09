//
//  SimpleTimerView.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/12/03.
//

import SwiftUI

struct SimpleTimerView: View {
    @StateObject private var phaseTimer = PhaseTimer(seconds: 300, title: "5分タイマー")
    @State private var selectedMinutes: Int = 5
    @State private var showingAlert = false
    @State private var isTimerActive = false // タイマーがアクティブかどうかの状態
    
    private let minuteOptions = Array(1...60)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                // タイマー設定セクション
                VStack(spacing: 20) {
                    Picker("分", selection: $selectedMinutes) {
                        ForEach(minuteOptions, id: \.self) { minute in
                            Text("\(minute)分")
                                .tag(minute)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                }
                
                // タイマー表示セクション
                if isTimerActive {
                    VStack(spacing: 16) {
                        Text(phaseTimer.formattedTime)
                            .font(.system(size: 48, weight: .bold, design: .monospaced))
                            .foregroundColor(phaseTimer.remainingSeconds <= 60 ? .red : .primary)
                            .opacity(phaseTimer.isBlinking ? 0.3 : 1.0)
                        
                        // 操作ボタン
                        HStack(spacing: 16) {
                            Button(action: {
                                if phaseTimer.isRunning {
                                    phaseTimer.stop()
                                } else {
                                    phaseTimer.start()
                                }
                            }) {
                                Image(systemName: phaseTimer.isRunning ? "pause.circle.fill" : "play.circle.fill")
                                    .font(.system(size: 44))
                                    .foregroundColor(phaseTimer.isRunning ? .orange : .green)
                            }
                            
                            Button(action: resetTimer) {
                                Image(systemName: "stop.circle.fill")
                                    .font(.system(size: 44))
                                    .foregroundColor(.red)
                            }
                        }
                    }
                } else {
                    Button(action: createTimer) {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 44))
                            .foregroundColor(.green)
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("シンプルタイマー")
            .navigationBarTitleDisplayMode(.inline)
            .alert("時間終了！", isPresented: $showingAlert) {
                Button("OK") {
                    resetTimer()
                }
            } message: {
                Text("設定した時間が経過しました。")
            }
            .onChange(of: phaseTimer.didEndPhase) { _, isCompleted in
                if isCompleted == true {
                    showingAlert = true
                }
            }
        }
    }
    
    private func createTimer() {
        let seconds = selectedMinutes * 60
        
        // 新しいタイマーを設定
        phaseTimer.stop() // 既存のタイマーを停止
        phaseTimer.remainingSeconds = seconds
        phaseTimer.didEndPhase = false
        phaseTimer.isBlinking = false
        
        isTimerActive = true
        phaseTimer.start()
    }
    
    private func resetTimer() {
        phaseTimer.stop()
        isTimerActive = false
    }
}

#Preview {
    SimpleTimerView()
}
