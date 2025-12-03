//
//  SimpleTimerView.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/12/03.
//

import SwiftUI

struct SimpleTimerView: View {
    @StateObject private var timerModel = TimerModel(seconds: 300, title: "5分タイマー") // デフォルト5分
    @State private var selectedMinutes: Int = 5
    @State private var showingAlert = false
    @State private var isTimerActive = false // タイマーがアクティブかどうかの状態
    
    private let minuteOptions = Array(1...60)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
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
                    VStack(spacing: 15) {
                        Text("残り時間")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text(timerModel.formattedTime)
                            .font(.system(size: 48, weight: .bold, design: .monospaced))
                            .foregroundColor(timerModel.remainingSeconds <= 60 ? .red : .primary)
                            .opacity(timerModel.isBlinking ? 0.3 : 1.0)
                        
                        // 操作ボタン
                        HStack(spacing: 20) {
                            Button(action: {
                                if timerModel.isRunning {
                                    timerModel.stop()
                                } else {
                                    timerModel.start()
                                }
                            }) {
                                Image(systemName: timerModel.isRunning ? "pause.circle.fill" : "play.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(timerModel.isRunning ? .orange : .green)
                            }
                            
                            Button(action: resetTimer) {
                                Image(systemName: "stop.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.red)
                            }
                        }
                    }
                } else {
                    // 開始ボタン
                    Button(action: createTimer) {
                        Label("タイマー開始", systemImage: "timer")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 15)
                            .background(Color.blue)
                            .cornerRadius(10)
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
            .onChange(of: timerModel.isCompleted) { _, isCompleted in
                if isCompleted == true {
                    showingAlert = true
                }
            }
        }
    }
    
    private func createTimer() {
        let seconds = selectedMinutes * 60
        
        // 新しいタイマーを設定
        timerModel.stop() // 既存のタイマーを停止
        timerModel.remainingSeconds = seconds
        timerModel.isCompleted = false
        timerModel.isBlinking = false
        
        isTimerActive = true
        timerModel.start()
    }
    
    private func resetTimer() {
        timerModel.stop()
        isTimerActive = false
    }
}

#Preview {
    SimpleTimerView()
}
