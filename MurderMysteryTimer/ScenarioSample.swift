//
//  ScenarioSample.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/11/08.
//

struct ScenarioSample {
    static let scenarios: [Scenario] = [
        Scenario(
            id: 1,
            title: "ストーリー1",
            phases: [
                ScenarioPhase(id: 1, seconds: 900, subtitle: "第一幕：導入"),
                ScenarioPhase(id: 2, seconds: 1200, subtitle: "第二幕：調査"),
                ScenarioPhase(id: 3, seconds: 600, subtitle: "第三幕：推理"),
                ScenarioPhase(id: 4, seconds: 300, subtitle: "最終幕：解決")
            ]
        ),
        Scenario(
            id: 2,
            title: "ストーリー2",
            phases: [
                ScenarioPhase(id: 1, seconds: 600, subtitle: "オープニング"),
                ScenarioPhase(id: 2, seconds: 1500, subtitle: "事件発生"),
                ScenarioPhase(id: 3, seconds: 1800, subtitle: "証拠収集"),
                ScenarioPhase(id: 4, seconds: 900, subtitle: "推理タイム"),
                ScenarioPhase(id: 5, seconds: 300, subtitle: "真相発表")
            ]
        ),
        Scenario(
            id: 3,
            title: "ストーリー3",
            phases: [
                ScenarioPhase(id: 1, seconds: 300, subtitle: "キャラクター紹介"),
                ScenarioPhase(id: 2, seconds: 1200, subtitle: "第一の事件"),
                ScenarioPhase(id: 3, seconds: 900, subtitle: "第一の調査"),
                ScenarioPhase(id: 4, seconds: 1200, subtitle: "第二の事件"),
                ScenarioPhase(id: 5, seconds: 900, subtitle: "第二の調査"),
                ScenarioPhase(id: 6, seconds: 600, subtitle: "最終推理"),
                ScenarioPhase(id: 7, seconds: 300, subtitle: "エピローグ")
            ]
        )
    ]
}