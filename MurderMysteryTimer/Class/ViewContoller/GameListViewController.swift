//
//  GameListViewController.swift
//  MurderMysteryTimer
//
//  Created by kazumi hayashida on 2022/12/27.
//

import UIKit

final class GameListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    private var games = [Game]()

    override func viewDidLoad() {
        super.viewDidLoad()

        games = DataManager.shared.fetchGames()

        tableView.dataSource = self
        tableView.rowHeight = 60.0

        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        navigationItem.rightBarButtonItem = item
    }

    @objc private func addButton() {

    }
}

extension GameListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        games.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let game = games[indexPath.row]
        cell.textLabel?.text = game.title
        return cell
    }
}
