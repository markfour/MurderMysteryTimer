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

    func intervalToMinutesString() -> String? {
        // TODO 秒数対応をする
        let minutes = interval / 60
        return String(format: "%d:00", Int(minutes))
    }
}
