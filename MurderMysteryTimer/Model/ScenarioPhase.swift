//
//  ScenarioPhase.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/11/05.
//

struct ScenarioPhase: Identifiable, Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case id, title, seconds
    }
    
    enum Status: Codable {
        case playing
        case stop
    }
    
    var id: Int
    var title: String
    var seconds: Int
    var status: Status = .stop
    var totalTime: String {
        seconds.toMinuteSecondString
    }
    var activeSeconds: Int {
        get {
            return _activeSeconds ?? seconds
        }
        set {
            _activeSeconds = newValue
        }
    }
    
    private var _activeSeconds: Int?
    
    init(id: Int, title: String, seconds: Int) {
        self.id = id
        self.seconds = seconds
        self.title = title
    }
}
