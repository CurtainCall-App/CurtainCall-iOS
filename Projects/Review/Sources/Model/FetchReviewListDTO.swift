//
//  FetchReviewListDTO.swift
//  Review
//
//  Created by 김민석 on 3/16/24.
//

import Foundation

public struct FetchReviewListDTO: Decodable {
    let content: [FetchReviewListResult]
}

// MARK: - Content
public struct FetchReviewListResult: Equatable, Decodable {
    let id: Int
    let showId: String
    let grade: Int
    let content: String
    let creatorId: Int
    let creatorNickname: String
    let creatorImageUrl: String
    let createdAt: String?
    let likeCount: Int?
}
