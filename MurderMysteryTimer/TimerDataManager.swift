//
//  TimerDataManager.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/10/31.
//

import Foundation
import SwiftUI
internal import Combine

class TimerDataManager: ObservableObject {
    static let shared = TimerDataManager()
    
    private init() {}
    
    // MARK: - Sample Data
    @Published var timerItems: [ScenarioPhase] = [
        ScenarioPhase(id: 1, seconds: 900, subtitle: "キャラクターシート読み込み"),
        ScenarioPhase(id: 2, seconds: 1200, subtitle: "第一捜査"),
        ScenarioPhase(id: 3, seconds: 900, subtitle: "第一推理"),
        ScenarioPhase(id: 4, seconds: 1200, subtitle: "第二捜査"),
        ScenarioPhase(id: 5, seconds: 900, subtitle: "第二推理"),
        ScenarioPhase(id: 6, seconds: 300, subtitle: "投票"),
        ScenarioPhase(id: 7, seconds: 300, subtitle: "アクション"),
        ScenarioPhase(id: 8, seconds: 900, subtitle: "エンディング"),
    ]
    
    // MARK: - Utility Methods
    func createTimerModels() -> [Int: TimerModel] {
        var models: [Int: TimerModel] = [:]
        for item in timerItems {
            models[item.id] = TimerModel(seconds: item.seconds, title: item.subtitle)
        }
        return models
    }
    
    func findItem(by id: Int) -> ScenarioPhase? {
        return timerItems.first { $0.id == id }
    }
    
    var totalItems: Int {
        return timerItems.count
    }
    
    // MARK: - Data Manipulation
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
