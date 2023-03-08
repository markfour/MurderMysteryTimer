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
    let phases: [GamePhase]

    init(id: Int, title: String, color: String? = nil, phases: [GamePhase]) {
        self.id = id
        self.title = title
        self.color = color
        self.phases = phases
    }
}
