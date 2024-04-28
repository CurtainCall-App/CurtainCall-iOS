//
//  FetchShowRecomandationResponseDTO.swift
//  Home
//
//  Created by 김민석 on 4/28/24.
//

import Foundation

import Common

// MARK: - Welcome
public struct FetchShowRecomandationResponseDTO: Decodable, Equatable {
    let content: [FetchShowRecomandationResponseResult]
}

// MARK: - Content
public struct FetchShowRecomandationResponseResult: Decodable, Equatable, Hashable {
    let id: Int
    let description: String
    let showId: String
    let name: String
    let genre: Genre
    let startDate: String
    let endDate: String
    let poster: String
}
