//
//  TimerDataManager.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/10/31.
//

import Foundation
import SwiftUI
internal import Combine

final class TimerDataManager: ObservableObject {
    static let shared = TimerDataManager()

    private init() {}

    @Published var timerItems: [ScenarioPhase] = [
        ScenarioPhase(id: 1, title: "キャラクターシート読み込み", seconds: 900),
        ScenarioPhase(id: 2, title: "第一捜査", seconds: 1200),
        ScenarioPhase(id: 3, title: "第一推理", seconds: 900),
        ScenarioPhase(id: 4, title: "第二捜査", seconds: 1200),
        ScenarioPhase(id: 5, title: "第二推理", seconds: 900),
        ScenarioPhase(id: 6, title: "投票", seconds: 300),
        ScenarioPhase(id: 7, title: "アクション", seconds: 300),
        ScenarioPhase(id: 8, title: "エンディング", seconds: 900),
    ]

    func createTimerModels() -> [Int: PhaseTimer] {
        var models: [Int: PhaseTimer] = [:]
        for item in timerItems {
            models[item.id] = PhaseTimer(seconds: item.seconds, title: item.title)
        }
        return models
    }

    func findItem(by id: Int) -> ScenarioPhase? {
        return timerItems.first { $0.id == id }
    }

    var totalItems: Int {
        return timerItems.count
    }

    func addItem(_ item: ScenarioPhase) {
        timerItems.append(item)
    }

    func removeItem(id: Int) {
        timerItems.removeAll { $0.id == id }
    }

    func updateItem(_ item: ScenarioPhase) {
        if let index = timerItems.firstIndex(where: { $0.id == item.id }) {
            timerItems[index] = item
        }
    }
}
