//
//  DataManager.swift
//  MurderMysteryTimer
//
//  Created by kazumi hayashida on 2023/01/03.
//

import Foundation

final class DataManager {
    let shared = DataManager()

    func fetchGames() -> [Game] {
        return MockGames.games()
    }
}
