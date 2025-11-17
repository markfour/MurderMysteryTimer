//
//  ScenarioPhase.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/11/05.
//

struct ScenarioPhase: Identifiable, Codable {
    enum CodingKeys: String, CodingKey {
        case id, seconds, subtitle, status
    }
    
    enum Status: Codable {
        case playing
        case stop
    }
    
    var id: Int
    var title: String {
        seconds.toMinuteSecondString
    }
    var seconds: Int
    var subtitle: String
    var status: Status = .stop
    var activeSeconds: Int {
        get {
            return _activeSeconds ?? seconds
        }
        set {
            _activeSeconds = newValue
        }
    }
    
    private var _activeSeconds: Int?
    
    init(id: Int, seconds: Int, subtitle: String, status: Status? = nil, _activeSeconds: Int? = nil) {
        self.id = id
        self.seconds = seconds
        self.subtitle = subtitle
        self.status = status ?? .stop
        self._activeSeconds = _activeSeconds
    }
}
