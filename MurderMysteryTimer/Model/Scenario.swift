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
    
    static var samplePhases: [ScenarioPhase] {
        return [ScenarioPhase(id: 1, title: "導入", seconds: 500),
                ScenarioPhase(id: 2, title: "自己紹介", seconds: 500),
                ScenarioPhase(id: 3, title: "第1調査", seconds: 25*60),
                ScenarioPhase(id: 4, title: "第1全体会議", seconds: 10*60),
                ScenarioPhase(id: 5, title: "第2調査", seconds: 25*60),
                ScenarioPhase(id: 6, title: "第2全体会議", seconds: 10*60),
                ScenarioPhase(id: 7, title: "最終弁論", seconds: 1*60),
                ScenarioPhase(id: 8, title: "犯人投票", seconds: 10*60)]
    }
    
    init(id: Int, title: String, phases: [ScenarioPhase]) {
        self.id = id
        self.title = title
        self.phases = phases
    }
    
    init(id: Int, title: String, addSamplePhase: Bool) {
        self.id = id
        self.title = title
        if addSamplePhase {
            self.phases = Scenario.samplePhases
        } else {
            self.phases = []
        }
    }
}
