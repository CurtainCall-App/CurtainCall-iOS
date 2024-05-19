//
//  FetchToOpenShowResponseDTO.swift
//  Home
//
//  Created by 김민석 on 4/28/24.
//

import Foundation

import Common

public struct FetchToOpenShowResponseDTO: Decodable, Equatable, Hashable {
    let content: [FetchToOpenShowResult]
}

public struct FetchToOpenShowResult: Decodable, Equatable, Hashable {
    let id, name, startDate, endDate: String
    let facilityName: String
    let poster: String
    let genre: Genre
    let showTimes: [ShowTime]
    let runtime: String
    let reviewCount, reviewGradeSum, reviewGradeAvg: Int
}
