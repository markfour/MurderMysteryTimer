//
//  TimerDataProtocol.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/10/31.
//

import Foundation

protocol TimerDataProviding {
    var timerItems: [ListItem] { get }
    func createTimerModels() -> [Int: TimerModel]
    func findItem(by id: Int) -> ListItem?
}

// 実際のデータプロバイダー
struct DefaultTimerDataProvider: TimerDataProviding {
    let timerItems: [ListItem] = [
        ListItem(id: 1, seconds: 900, subtitle: "キャラクターシート読み込み"),
        ListItem(id: 2, seconds: 1200, subtitle: "第一捜査"),
        ListItem(id: 3, seconds: 900, subtitle: "第一推理"),
        ListItem(id: 4, seconds: 1200, subtitle: "第二捜査"),
        ListItem(id: 5, seconds: 900, subtitle: "第二推理"),
        ListItem(id: 6, seconds: 300, subtitle: "投票"),
        ListItem(id: 7, seconds: 300, subtitle: "アクション"),
        ListItem(id: 8, seconds: 900, subtitle: "エンディング"),
    ]
    
    func createTimerModels() -> [Int: TimerModel] {
        var models: [Int: TimerModel] = [:]
        for item in timerItems {
            models[item.id] = TimerModel(seconds: item.seconds, title: item.subtitle)
        }
        return models
    }
    
    func findItem(by id: Int) -> ListItem? {
        return timerItems.first { $0.id == id }
    }
}

// テスト用のモックデータプロバイダー
struct MockTimerDataProvider: TimerDataProviding {
    let timerItems: [ListItem] = [
        ListItem(id: 1, seconds: 10, subtitle: "テスト1"),
        ListItem(id: 2, seconds: 20, subtitle: "テスト2"),
    ]
    
    func createTimerModels() -> [Int: TimerModel] {
        var models: [Int: TimerModel] = [:]
        for item in timerItems {
            models[item.id] = TimerModel(seconds: item.seconds, title: item.subtitle)
        }
        return models
    }
    
    func findItem(by id: Int) -> ListItem? {
        return timerItems.first { $0.id == id }
    }
}