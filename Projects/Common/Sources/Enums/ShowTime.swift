//
//  ShowTime.swift
//  Common
//
//  Created by 김민석 on 4/28/24.
//

import Foundation

public struct ShowTime: Decodable, Hashable {
    public let dayOfWeek: DayOfWeek
    public let time: String
}

public enum DayOfWeek: String, Decodable {
    case friday = "FRIDAY"
    case hol = "HOL"
    case monday = "MONDAY"
    case saturday = "SATURDAY"
    case sunday = "SUNDAY"
    case thursday = "THURSDAY"
    case tuesday = "TUESDAY"
    case wednesday = "WEDNESDAY"
    
    public init?(week: Int) {
        switch week {
        case 1: self = .saturday
        case 2: self = .sunday
        case 3: self = .monday
        case 4: self = .tuesday
        case 5: self = .wednesday
        case 6: self = .thursday
        case 7: self = .friday
        default: return nil
        }
    }
}
