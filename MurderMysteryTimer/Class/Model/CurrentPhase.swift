//
//  CurrentPhase.swift
//  MurderMysteryTimer
//
//  Created by kazumi hayashida on 2022/12/27.
//

import Foundation

final class CurrentGame {
    let phaseIndex: Int
    let game: Game
    let currentInterval: TimeInterval

    init(phaseIndex: Int, game: Game, currentInterval: TimeInterval) {
        self.phaseIndex = phaseIndex
        self.game = game
        self.currentInterval = currentInterval
    }
}
