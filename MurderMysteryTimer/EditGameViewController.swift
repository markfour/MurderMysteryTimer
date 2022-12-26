//
//  EditGameViewController.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2022/12/26.
//

import UIKit

final class EditGameViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "EditGameCell", bundle: nil), forCellReuseIdentifier: "EditGameCell")
    }
}

extension EditGameViewController: UITableViewDelegate {

}

extension EditGameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditGameCell")!

        return cell
    }
}
