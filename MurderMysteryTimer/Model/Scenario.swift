//
//  Scenario.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/11/06.
//

struct Scenario: Identifiable, Codable {
    var id: Int
    var title: String
    var phases: [ScenarioPhase]
}
