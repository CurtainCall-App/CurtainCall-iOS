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
    
    public static let authHeader: [String: String] = {
        var header: [String: String] = [:]
        if let accessToken = UserDefaults.standard.string(forKey: UserDefaultKeys.accessToken.rawValue) {
            header.updateValue("Bearer \(accessToken)", forKey: "Authorization")
        }
        return header
    }()
    
    public static func convertDateStringToDate(dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.date(from: dateString)
    }
    
    public static func convertDateToAPIString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: date)
    }
    
    public static func convertAPIDateStringToDay(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        let convertFormaater = DateFormatter()
        convertFormaater.dateFormat = "yyyy-MM-dd (E)"
        convertFormaater.locale = Locale(identifier: "ko-KR")
        if let date = formatter.date(from: dateString) {
            return convertFormaater.string(from: date)
        } else {
            return "날짜 정보 없음"
        }
    }
    
    public static func convertAPIDateStringToTime(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        let convertFormaater = DateFormatter()
        convertFormaater.dateFormat = "HH:mm"
        convertFormaater.locale = Locale(identifier: "ko-KR")
        if let date = formatter.date(from: dateString) {
            return convertFormaater.string(from: date)
        } else {
            return "날짜 정보 없음"
        }
    }
    
    public static func convertAPIDateForrmatToDate(dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        formatter.locale = Locale(identifier: "ko-KR")
        return formatter.date(from: dateString)
    }
    
    public static func convertIntInComma(value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(integerLiteral: value)) ?? ""
    }
}
