//
//  EditGameViewController.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2022/12/26.
//

import UIKit

final class GamePhaseListViewController: UIViewController {
    var game: Game = Game(id: 0, title: "", phases: [])

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        let saveButton = UIBarButtonItem(systemItem: .save)
        saveButton.action = #selector(didTapSaveButton)
        navigationItem.rightBarButtonItem = saveButton
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "GamePhaseCell", bundle: nil), forCellReuseIdentifier: "GamePhaseCell")
    }

    @objc private func didTapSaveButton() {
        // TODO save
    }
}

extension GamePhaseListViewController: UITableViewDelegate {

}

extension GamePhaseListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        game.phases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GamePhaseCell")! as! GamePhaseCell
        cell.updateCell(phase: game.phases[indexPath.row])
        return cell
    }
}
