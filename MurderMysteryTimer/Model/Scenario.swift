//
//  Scenario.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/11/06.
//

struct Scenario: Identifiable, Codable, Equatable {
    var id: Int
    var title: String
    var phases: [ScenarioPhase]
    
    var samplePhases: [ScenarioPhase] {
        return [ScenarioPhase(id: 1, title: "導入", seconds: 500),
                ScenarioPhase(id: 1, title: "自己紹介", seconds: 500),
                ScenarioPhase(id: 1, title: "第1調査フェーズ", seconds: 25*60),
                ScenarioPhase(id: 1, title: "第1全体会議フェーズ", seconds: 10*60),
                ScenarioPhase(id: 1, title: "第2調査フェーズ", seconds: 25*60),
                ScenarioPhase(id: 1, title: "第3全体会議フェーズ", seconds: 10*60),
                ScenarioPhase(id: 1, title: "最終弁論", seconds: 1*60),
                ScenarioPhase(id: 1, title: "犯人拘束", seconds: 10*60)]

    }
}
