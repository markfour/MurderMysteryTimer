//
//  GamePhase.swift
//  MurderMysteryTimer
//
//  Created by kazumi hayashida on 2022/12/27.
//

import Foundation

final class GamePhase {
    var title: String
    var interval: TimeInterval

    init(title: String, interval: TimeInterval) {
        self.title = title
        self.interval = interval
    }
}
