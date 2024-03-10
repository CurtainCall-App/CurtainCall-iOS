//
//  FetchFacilityResponseDTO.swift
//  Show
//
//  Created by 김민석 on 3/10/24.
//

import Foundation

public struct FetchFacilityResponseDTO: Decodable, Hashable {
    let id, name: String
    let hallNum: Int
    let characteristic: String
    let openingYear, seatNum: Int
    let phone: String
    let homepage: String
    let address: String
    let latitude, longitude: Double
}
