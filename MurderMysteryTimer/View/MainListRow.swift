//
//  MainListRow.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/12/09.
//

import SwiftUI

struct MainListRow: View {
    @ObservedObject var timerModel: PhaseTimerModel
    let onPlayButtonTap: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(timerModel.formattedTime)
                    .font(.headline)
                
                Text(timerModel.title)
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

#Preview {
    MainListRow(
        timerModel: PhaseTimerModel(seconds: 300, title: "フェーズ"),
        onPlayButtonTap: {}
    )
}
