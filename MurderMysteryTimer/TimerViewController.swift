//
//  TimerViewController.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2022/12/19.
//

import UIKit

final class TimerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapEditGameButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "EditGameViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EditGameViewController") as! EditGameViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
