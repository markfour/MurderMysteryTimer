//
//  TimerDataProtocol.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/10/31.
//

import Foundation

protocol TimerDataProviding {
    var timerItems: [ScenarioPhase] { get }
    func createTimerModels() -> [Int: PhaseTimer]
    func findItem(by id: Int) -> ScenarioPhase?
}

struct DefaultTimerDataProvider: TimerDataProviding {
    let timerItems: [ScenarioPhase] = [
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
}

struct MockTimerDataProvider: TimerDataProviding {
    let timerItems: [ScenarioPhase] = [
        ScenarioPhase(id: 1, title: "テスト1", seconds: 10),
        ScenarioPhase(id: 2, title: "テスト2", seconds: 20),
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
}
