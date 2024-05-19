//
//  FetchShowCostShowResponseDTO.swift
//  Home
//
//  Created by 김민석 on 5/3/24.
//

import Foundation

import Common

public struct FetchShowCostShowResponseDTO: Equatable, Decodable {
    let content: [FetchShowCostShowResult]
}

public struct FetchShowCostShowResult: Equatable, Decodable {
    let id, name, startDate, endDate: String
    let poster: String
    let genre: Genre
    let minTicketPrice: Int
}
