//
//  FetchShowToEndResponseDTO.swift
//  Home
//
//  Created by 김민석 on 5/3/24.
//

import Foundation

import Common

public struct FetchShowToEndResponseDTO: Equatable, Decodable {
    let content: [FetchShowToEndResult]
}

public struct FetchShowToEndResult: Equatable, Decodable {
    let id, name, startDate, endDate: String
    let facilityName: String
    let poster: String
    let genre: Genre
    let showTimes: [ShowTime]
    let runtime: String
    let reviewCount, reviewGradeSum: Int
    let reviewGradeAvg: Double
}
