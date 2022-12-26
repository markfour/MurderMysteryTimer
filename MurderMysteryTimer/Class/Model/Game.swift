//
//  Game.swift
//  MurderMysteryTimer
//
//  Created by kazumi hayashida on 2022/12/27.
//

import Foundation

final class Game {
    let title: String
    let phase: [GamePhase]

    init(title: String, phase: [GamePhase]) {
        self.title = title
        self.phase = phase
    }
}
