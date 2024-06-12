//
//  EditGameCell.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2022/12/27.
//

import UIKit

protocol GamePhaseCellProtocol {
    func update(phase: GamePhase)
}

final class GamePhaseCell: UITableViewCell {
    var gamePhase: GamePhase = GamePhase(title: "", interval: 0)
    var delegate: GamePhaseCellProtocol?

    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var timeTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()

        timeTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func updateCell(phase: GamePhase) {
        gamePhase = phase

        titleTextField.text = gamePhase.title
        timeTextField.text = gamePhase.intervalToMinutesString()
    }
}

extension GamePhaseCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        gamePhase.title = textField.text ?? ""
        delegate?.update(phase: gamePhase)
    }
}
