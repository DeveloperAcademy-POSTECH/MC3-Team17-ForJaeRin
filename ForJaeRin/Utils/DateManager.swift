//
//  DateFormatter.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/17.
//

import Foundation

enum DateManager {
    static func formatDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }
    
    static func secondsToTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d", minutes) + ":" + String(format: "%02d", seconds)
    }
    
    static func intToTime(second: Int) -> String {
        if second >= 0 {
            let minutes = second / 60
            let seconds = second % 60
            return "+" + String(format: "%02d", minutes) + ":" + String(format: "%02d", seconds)
        } else {
            let second = second * (-1)
            let minutes = second / 60
            let seconds = second % 60
            return "-" + String(format: "%02d", minutes) + ":" + String(format: "%02d", seconds)
        }
    }
}
