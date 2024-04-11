//
//  FetchPartyListResponseDTO.swift
//  Party
//
//  Created by 김민석 on 4/10/24.
//

import Foundation

public struct FetchPartyListResponseDTO: Decodable {
    let content: [FetchPartyListResult]
}

public struct FetchPartyListResult: Hashable, Equatable, Decodable {
    let id: Int
    let title: String
    let content: String
    let curMemberNum, maxMemberNum: Int
    let createdAt: String
    let creatorId: Int
    let creatorNickname: String
    let creatorImageUrl: String?
    let showId, showName: String
    let showPoster: String
    let showAt: String
    let facilityId: String
    let facilityName: String
}
