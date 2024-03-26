//
//  FetchShowResponseDTO.swift
//  Show
//
//  Created by 김민석 on 2/25/24.
//

import Foundation

import Common

public struct FetchShowResponseDTO: Decodable {
    let content: [ShowResponseContent]
}

public struct ShowResponseContent: Hashable, Equatable, Decodable {
    public static func == (lhs: ShowResponseContent, rhs: ShowResponseContent) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    let name: String
    let startDate: String
    let endDate: String
    let facilityName: String
    let poster: String
    let genre: Genre
    let showTimes: [ShowTime]
    let runtime: String
    let reviewCount: Int
    let reviewGradeSum: Int
    let reviewGradeAvg: Double
}

struct ShowTime: Decodable, Hashable {
    let dayOfWeek: DayOfWeek
    let time: String
}

enum DayOfWeek: String, Decodable {
    case friday = "FRIDAY"
    case hol = "HOL"
    case monday = "MONDAY"
    case saturday = "SATURDAY"
    case sunday = "SUNDAY"
    case thursday = "THURSDAY"
    case tuesday = "TUESDAY"
    case wednesday = "WEDNESDAY"
}
