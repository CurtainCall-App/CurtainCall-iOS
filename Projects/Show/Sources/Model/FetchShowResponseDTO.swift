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


