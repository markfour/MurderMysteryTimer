//
//  ScenarioDataManager.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/11/16.
//

import Foundation
import SwiftUI
internal import Combine

class ScenarioDataManager: ObservableObject {
    static let shared = ScenarioDataManager()
    
    private let userDefaults = UserDefaults.standard
    private let scenariosKey = "saved_scenarios"
    
    @Published var scenarios: [Scenario] = []
    
    private init() {
        loadScenarios()
    }
    
    // MARK: - Data Persistence
    
    /// UserDefaultsからシナリオデータを読み込む
    func loadScenarios() {
        if let data = userDefaults.data(forKey: scenariosKey) {
            do {
                let decodedScenarios = try JSONDecoder().decode([Scenario].self, from: data)
                self.scenarios = decodedScenarios
            } catch {
                print("シナリオの読み込みに失敗しました: \(error)")
                // 読み込みに失敗した場合はサンプルデータを使用
                loadSampleData()
            }
        } else {
            // 初回起動時はサンプルデータを読み込み
            loadSampleData()
        }
    }
    
    /// UserDefaultsにシナリオデータを保存する
    func saveScenarios() {
        do {
            let data = try JSONEncoder().encode(scenarios)
            userDefaults.set(data, forKey: scenariosKey)
        } catch {
            print("シナリオの保存に失敗しました: \(error)")
        }
    }
    
    /// サンプルデータを読み込む
    private func loadSampleData() {
        self.scenarios = ScenarioSample.scenarios
        saveScenarios() // サンプルデータも保存しておく
    }
    
    // MARK: - Data Manipulation
    
    /// 新しいシナリオを追加
    func addScenario(_ scenario: Scenario) {
        scenarios.append(scenario)
        saveScenarios()
    }
    
    /// シナリオを削除
    func removeScenario(id: Int) {
        scenarios.removeAll { $0.id == id }
        saveScenarios()
    }
    
    /// シナリオを更新
    func updateScenario(_ scenario: Scenario) {
        if let index = scenarios.firstIndex(where: { $0.id == scenario.id }) {
            scenarios[index] = scenario
            saveScenarios()
        }
    }
    
    /// IDでシナリオを検索
    func findScenario(by id: Int) -> Scenario? {
        return scenarios.first { $0.id == id }
    }
    
    /// 新しいシナリオIDを生成
    func generateNewScenarioId() -> Int {
        return (scenarios.map { $0.id }.max() ?? 0) + 1
    }
    
    /// 指定されたシナリオ内で新しいフェーズIDを生成
    func generateNewPhaseId(for scenario: Scenario) -> Int {
        return (scenario.phases.map { $0.id }.max() ?? 0) + 1
    }
    
    // MARK: - Phase Management
    
    /// シナリオにフェーズを追加
    func addPhase(to scenarioId: Int, phase: ScenarioPhase) {
        if let index = scenarios.firstIndex(where: { $0.id == scenarioId }) {
            scenarios[index].phases.append(phase)
            saveScenarios()
        }
    }
    
    /// シナリオからフェーズを削除
    func removePhase(from scenarioId: Int, phaseId: Int) {
        if let scenarioIndex = scenarios.firstIndex(where: { $0.id == scenarioId }) {
            scenarios[scenarioIndex].phases.removeAll { $0.id == phaseId }
            saveScenarios()
        }
    }
    
    /// フェーズを更新
    func updatePhase(in scenarioId: Int, phase: ScenarioPhase) {
        if let scenarioIndex = scenarios.firstIndex(where: { $0.id == scenarioId }),
           let phaseIndex = scenarios[scenarioIndex].phases.firstIndex(where: { $0.id == phase.id }) {
            scenarios[scenarioIndex].phases[phaseIndex] = phase
            saveScenarios()
        }
    }
    
    // MARK: - Utility Methods
    
    /// 全シナリオの総数を取得
    var totalScenarios: Int {
        return scenarios.count
    }
    
    /// 指定されたシナリオの総フェーズ数を取得
    func totalPhases(for scenarioId: Int) -> Int {
        return findScenario(by: scenarioId)?.phases.count ?? 0
    }
    
    /// 指定されたシナリオの総時間を取得（秒）
    func totalDuration(for scenarioId: Int) -> Int {
        return findScenario(by: scenarioId)?.phases.reduce(0) { $0 + $1.seconds } ?? 0
    }
    
    /// データをリセットしてサンプルデータを再読み込み
    func resetToSampleData() {
        loadSampleData()
    }
    
    /// 全データを削除
    func clearAllData() {
        scenarios.removeAll()
        userDefaults.removeObject(forKey: scenariosKey)
    }
}
