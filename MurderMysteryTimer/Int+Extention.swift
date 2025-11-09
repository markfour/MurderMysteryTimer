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
    
    var toHourMinuteString: String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        return String(format: "%02d:%02d", hours, minutes)
    }
}

