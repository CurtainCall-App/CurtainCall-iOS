//
//  FetchFavoriteShowListResponseDTO.swift
//  Show
//
//  Created by 김민석 on 8/10/24.
//

import Foundation

public struct FetchFavoriteShowListResponseDTO: Decodable {
    public let content: [FetchFavoriteShowListContent]
}

public struct FetchFavoriteShowListContent: Decodable {
    public let showId: String
    public let favorite: Bool
}
