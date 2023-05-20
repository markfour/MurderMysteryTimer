//
//  MockGames.swift
//  MurderMysteryTimer
//
//  Created by kazumi hayashida on 2022/12/30.
//

import Foundation

final class MockGames {
    static func games() -> [Game] {
        var games = [Game]()
        let phasees:[GamePhase] = [
            GamePhase(title: "オープニング", interval: 360),
            GamePhase(title: "話し合い1", interval: 360),
            GamePhase(title: "話し合い2", interval: 360),
            GamePhase(title: "犯人投票", interval: 360),
            GamePhase(title: "エンディング", interval: 360)
        ]
        games.append(Game(id: 0, title: "犯人はヤスー", phases: phasees))
        games.append(Game(id: 1, title: "別荘殺人事件", phases: phasees))
        games.append(Game(id: 2, title: "港の事件", phases: phasees))
        games.append(Game(id: 3, title: "屋敷の主人が死んだ", phases: phasees))
        return games
    }
}
