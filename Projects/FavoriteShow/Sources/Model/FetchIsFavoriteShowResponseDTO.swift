//
//  FetchIsFavoriteShowResponseDTO.swift
//  Show
//
//  Created by 김민석 on 11/23/24.
//

import Foundation

public struct FetchIsFavoriteShowResponseDTO: Decodable {
    public let content: [FetchIsFavoriteShowContent]
}

public struct FetchIsFavoriteShowContent: Decodable {
    public let showId: String
    public let favorite: Bool
}
