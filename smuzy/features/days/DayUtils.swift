//
//  DayUtils.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import Foundation

extension Date {
    func getFormattedDayLabel() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        let dayOfWeek = formatter.string(from: self)
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: self)
        let now = calendar.startOfDay(for: Date())
        let diffNow = -(calendar.dateComponents([.day], from: startOfDay, to: now).day ?? 0)
        
        var formattedDate = ""
        
        switch diffNow {
        case 0:
            formattedDate = "Today - \(dayOfWeek)"
        case 1:
            formattedDate = "Tomorrow - \(dayOfWeek)"
        case -1:
            formattedDate = "Yesterday - \(dayOfWeek)"
        default:
            formatter.dateFormat = "MM.dd.yy - "
            formattedDate = formatter.string(from: self) + dayOfWeek
        }
        
        return formattedDate.lowercased()
    }
}
