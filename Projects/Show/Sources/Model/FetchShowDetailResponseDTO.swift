//
//  FetchShowDetailResponseDTO.swift
//  Show
//
//  Created by 김민석 on 3/10/24.
//

import Foundation

public struct ShowDetailResponseContent: Hashable, Equatable, Decodable {
    public static func == (lhs: ShowDetailResponseContent, rhs: ShowDetailResponseContent) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    let name: String
    let startDate: String
    let endDate: String
    let facilityId: String
    let facilityName: String
    let crew: String
    let cast: String
    let runtime: String
    let age: String
    let enterprise: String
    let ticketPrice: String
    let poster: String
    let story: String
    let genre: Genre
    let introductionImages: [String]
    let showTimes: [ShowTime]?
    let reviewCount: Int
    let reviewGradeSum: Int
    let reviewGradeAvg: Double
}
