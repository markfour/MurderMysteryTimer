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
            title: "シナリオ1",
            phases: [
                ScenarioPhase(id: 1, title: "第一幕：導入", seconds: 5),
                ScenarioPhase(id: 2, title: "第二幕：調査", seconds: 1200),
                ScenarioPhase(id: 3, title: "第三幕：推理", seconds: 600),
                ScenarioPhase(id: 4, title: "最終幕：解決", seconds: 300)
            ]
        ),
        Scenario(
            id: 2,
            title: "シナリオ2",
            phases: [
                ScenarioPhase(id: 1, title: "オープニング", seconds: 600),
                ScenarioPhase(id: 2, title: "事件発生", seconds: 1500),
                ScenarioPhase(id: 3, title: "証拠収集", seconds: 1800),
                ScenarioPhase(id: 4, title: "推理タイム", seconds: 900),
                ScenarioPhase(id: 5, title: "真相発表", seconds: 300)
            ]
        ),
        Scenario(
            id: 3,
            title: "シナリオ3",
            phases: [
                ScenarioPhase(id: 1, title: "キャラクター紹介", seconds: 300),
                ScenarioPhase(id: 2, title: "第一の事件", seconds: 1200),
                ScenarioPhase(id: 3, title: "第一の調査", seconds: 900),
                ScenarioPhase(id: 4, title: "第二の事件", seconds: 1200),
                ScenarioPhase(id: 5, title: "第二の調査", seconds: 900),
                ScenarioPhase(id: 6, title: "最終推理", seconds: 600),
                ScenarioPhase(id: 7, title: "エピローグ", seconds: 300)
            ]
        )
    ]
}
