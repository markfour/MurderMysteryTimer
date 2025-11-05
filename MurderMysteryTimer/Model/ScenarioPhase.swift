//
//  ScenarioPhase.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/11/05.
//

struct ScenarioPhase: Identifiable {
    enum status {
        case playing
        case stop
    }
    
    var id: Int
    var seconds: Int
    var subtitle: String
    var status: status = .stop
    
    var title: String {
        seconds.toMinuteSecondString
    }
}
