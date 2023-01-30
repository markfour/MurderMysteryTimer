//
//  GameCell.swift
//  MurderMysteryTimer
//
//  Created by kazumi hayashida on 2023/01/07.
//

import UIKit

final class GameCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var gameImageView: UIImageView!

    var game: Game? {
        didSet {
            titleLabel.text = game?.title
            if let color = game?.color {
                gameImageView.backgroundColor = UIColor(hex: color)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
