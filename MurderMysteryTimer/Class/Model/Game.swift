//
//  Game.swift
//  MurderMysteryTimer
//
//  Created by kazumi hayashida on 2022/12/27.
//

import Foundation

final class Game {
    let id: Int
    let title: String
    let color: String?
    let phase: [GamePhase]

    init(id: Int, title: String, color: String? = nil, phase: [GamePhase]) {
        self.id = id
        self.title = title
        self.color = color
        self.phase = phase
    }
}
