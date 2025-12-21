//
//  ScenarioDataManager.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/11/16.
//

import Foundation
import SwiftUI
internal import Combine

final class ScenarioDataManager: ObservableObject {
    static let shared = ScenarioDataManager()

    private let userDefaults = UserDefaults.standard
    private let scenariosKey = "saved_scenarios"

    @Published var scenarios: [Scenario] = []

    private init() {
        loadScenarios()
    }

    // MARK: - Data Persistence

    func loadScenarios() {
        if let data = userDefaults.data(forKey: scenariosKey) {
            do {
                let decodedScenarios = try JSONDecoder().decode([Scenario].self, from: data)
                self.scenarios = decodedScenarios
            } catch {
                print("シナリオの読み込みに失敗しました: \(error)")
                loadInitialData()
            }
        } else {
            loadInitialData()
        }
    }

    func saveScenarios() {
        do {
            let data = try JSONEncoder().encode(scenarios)
            userDefaults.set(data, forKey: scenariosKey)
        } catch {
            print("シナリオの保存に失敗しました: \(error)")
        }
    }

    private func loadInitialData() {
        self.scenarios = ScenarioSample.scenarios
        saveScenarios()
    }

    // MARK: - Data Manipulation

    func addScenario(_ scenario: Scenario) {
        scenarios.append(scenario)
        saveScenarios()
    }

    func removeScenario(id: Int) {
        scenarios.removeAll { $0.id == id }
        saveScenarios()
    }

    func updateScenario(_ scenario: Scenario) {
        if let index = scenarios.firstIndex(where: { $0.id == scenario.id }) {
            scenarios[index] = scenario
            saveScenarios()
        }
    }

    func findScenario(by id: Int) -> Scenario? {
        return scenarios.first { $0.id == id }
    }

    func generateNewScenarioId() -> Int {
        return (scenarios.map { $0.id }.max() ?? 0) + 1
    }

    func generateNewPhaseId(for scenario: Scenario) -> Int {
        return (scenario.phases.map { $0.id }.max() ?? 0) + 1
    }

    // MARK: - Phase Management

    func addPhase(to scenarioId: Int, phase: ScenarioPhase) {
        if let index = scenarios.firstIndex(where: { $0.id == scenarioId }) {
            scenarios[index].phases.append(phase)
            saveScenarios()
        }
    }

    func removePhase(from scenarioId: Int, phaseId: Int) {
        if let scenarioIndex = scenarios.firstIndex(where: { $0.id == scenarioId }) {
            scenarios[scenarioIndex].phases.removeAll { $0.id == phaseId }
            saveScenarios()
        }
    }

    func updatePhase(in scenarioId: Int, phase: ScenarioPhase) {
        if let scenarioIndex = scenarios.firstIndex(where: { $0.id == scenarioId }),
           let phaseIndex = scenarios[scenarioIndex].phases.firstIndex(where: { $0.id == phase.id }) {
            scenarios[scenarioIndex].phases[phaseIndex] = phase
            saveScenarios()
        }
    }

    // MARK: - Utility Methods

    var totalScenarios: Int {
        return scenarios.count
    }

    func totalPhases(for scenarioId: Int) -> Int {
        return findScenario(by: scenarioId)?.phases.count ?? 0
    }

    func totalDuration(for scenarioId: Int) -> Int {
        return findScenario(by: scenarioId)?.phases.reduce(0) { $0 + $1.seconds } ?? 0
    }

    func resetToSampleData() {
        loadInitialData()
    }

    func clearAllData() {
        scenarios.removeAll()
        userDefaults.removeObject(forKey: scenariosKey)
    }
}
