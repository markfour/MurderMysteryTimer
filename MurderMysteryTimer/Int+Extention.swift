//
//  Int+Extention.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/07/22.
//

import Foundation

extension Int {
    var toMinuteSecondString: String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

