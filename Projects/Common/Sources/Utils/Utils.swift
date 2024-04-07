//
//  Utils.swift
//  Common
//
//  Created by 김민석 on 4/7/24.
//

import Foundation

public struct Utils {
    public static let yearMonthDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        return formatter
    }()
    
    public static let weekdaySymbols: [String] = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko-KR")
        return calendar.veryShortWeekdaySymbols
    }()
}
