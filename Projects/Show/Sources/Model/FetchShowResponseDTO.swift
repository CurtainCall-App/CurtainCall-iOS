//
//  FetchShowResponseDTO.swift
//  Show
//
//  Created by 김민석 on 2/25/24.
//

import Foundation

import Common

public struct FetchShowResponseDTO: Decodable {
    public let content: [ShowResponseContent]
}

public struct ShowResponseContent: Hashable, Equatable, Decodable {
    public static func == (lhs: ShowResponseContent, rhs: ShowResponseContent) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id: String
    public let name: String
    public let startDate: String
    public let endDate: String
    public let facilityName: String
    public let poster: String
    public let genre: Genre
    public let showTimes: [ShowTime]
    public let runtime: String
    public let reviewCount: Int
    public let reviewGradeSum: Int
    public let reviewGradeAvg: Double
}

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
        case 1: self = .sunday
        case 2: self = .monday
        case 3: self = .tuesday
        case 4: self = .wednesday
        case 5: self = .thursday
        case 6: self = .friday
        case 7: self = .saturday
        default: return nil
        }
    }
}
