//
//  MainListActiveRow.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/12/10.
//

import SwiftUI

struct MainListActiveRow: View {
    @ObservedObject var phaseTimer: PhaseTimer
    let onPlayButtonTap: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(phaseTimer.title)
                    .font(.title)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                if !phaseTimer.didEndPhase || phaseTimer.remainingSeconds == 0 {
                    Text(phaseTimer.formattedTime)
                        .font(.system(size: 64, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            Spacer()
            
            if !phaseTimer.didEndPhase || phaseTimer.remainingSeconds == 0 {
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
    MainListActiveRow(
        phaseTimer: PhaseTimer(seconds: 300, title: "フェーズ"),
        onPlayButtonTap: {}
    )
}
