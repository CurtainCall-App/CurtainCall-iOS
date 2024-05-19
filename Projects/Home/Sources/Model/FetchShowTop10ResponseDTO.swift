//
//  FetchShowTop10ResponseDTO.swift
//  Home
//
//  Created by 김민석 on 4/28/24.
//

import Foundation

import Common

public struct FetchShowTop10ResponseDTO: Decodable, Hashable, Equatable {
    let content: [FetchShowTop10Result]
}

public struct FetchShowTop10Result: Decodable, Hashable, Equatable {
    let rank: Int
    let id, name, startDate, endDate: String
    let facilityName, poster: String
    let genre: Genre
    let showTimes: [ShowTime]
    let runtime: String
    let reviewCount: Int
    let reviewGradeSum: Int
    let reviewGradeAvg: Double
}
