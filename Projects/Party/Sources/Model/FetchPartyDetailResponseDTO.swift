//
//  FetchPartyDetailResponseDTO.swift
//  Party
//
//  Created by 김민석 on 4/27/24.
//

import Foundation

public struct FetchPartyDetailResponseDTO: Decodable, Equatable {
    let id: Int
    let title: String
    let content: String
    let curMemberNum: Int
    let maxMemberNum: Int
    let creatorId: Int
    let createdAt: String
    let creatorNickname: String
    let creatorImageUrl: String?
    let showId: String
    let showName: String
    let showPoster: String?
    let showAt: String
    let facilityId: String
    let facilityName: String
}
