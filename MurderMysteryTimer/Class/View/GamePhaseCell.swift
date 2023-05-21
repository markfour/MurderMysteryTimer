//
//  EditGameCell.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2022/12/27.
//

import UIKit

final class GamePhaseCell: UITableViewCell {
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var timeTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func updateCell() {

    }
}
