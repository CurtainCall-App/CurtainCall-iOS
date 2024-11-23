//
//  FetchIsFavoriteShowResponseDTO.swift
//  Show
//
//  Created by 김민석 on 11/23/24.
//

import Foundation

struct FetchIsFavoriteShowResponseDTO: Decodable {
    let content: [FetchIsFavoriteShowContent]
}

struct FetchIsFavoriteShowContent: Decodable {
    let showId: String
    let favorite: Bool
}
