//
//  MainListRow.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/12/09.
//

import SwiftUI

struct MainListRow: View {
    @ObservedObject var phaseTimer: PhaseTimer
    let onPlayButtonTap: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(phaseTimer.title)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                if !phaseTimer.didEndPhase && phaseTimer.initialSeconds != 0 {
                    Text(phaseTimer.formattedTime)
                        .font(.headline)
                }
            }
            Spacer()
            
            if !phaseTimer.didEndPhase && phaseTimer.initialSeconds != 0 {
                Button(action: onPlayButtonTap) {
                    Image(systemName: phaseTimer.isRunning ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(phaseTimer.isRunning ? .orange : .green)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#Preview {
    MainListRow(
        phaseTimer: PhaseTimer(seconds: 300, title: "フェーズ"),
        onPlayButtonTap: {}
    )
}
