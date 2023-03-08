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
        let phasees = [GamePhase]()
        games.append(Game(id: 0, title: "犯人はヤスー", phases: []))
        games.append(Game(id: 1, title: "別荘殺人事件", phases: []))
        games.append(Game(id: 2, title: "港の事件", phases: []))
        games.append(Game(id: 3, title: "屋敷の主人が死んだ", phases: []))
        return games
    }
}
