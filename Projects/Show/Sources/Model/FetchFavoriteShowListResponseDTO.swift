//
//  FetchFavoriteShowListResponseDTO.swift
//  Show
//
//  Created by 김민석 on 8/10/24.
//

import Foundation

import Common

public struct FetchFavoriteShowListResponseDTO: Decodable {
    public let content: [FetchFavoriteShowListContent]
}

public struct FetchFavoriteShowListContent: Hashable, Equatable, Decodable {
    public static func == (lhs: FetchFavoriteShowListContent, rhs: FetchFavoriteShowListContent) -> Bool {
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
}
