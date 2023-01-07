//
//  DataManager.swift
//  MurderMysteryTimer
//
//  Created by kazumi hayashida on 2023/01/03.
//

import Foundation

final class DataManager {
    static let shared = DataManager()

    private var games = [Game]()

    func fetchGames() -> [Game] {
        if games.isEmpty {
            games = MockGames.games()
        }

        return games
    }
}
