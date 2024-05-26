//
//  FetchNoticeListResponseDTO.swift
//  MyPage
//
//  Created by 김민석 on 5/26/24.
//

import Foundation

public struct FetchNoticeListResponseDTO: Decodable {
    public let content: [FetchNoticeListResult]
}

public struct FetchNoticeListResult: Hashable, Equatable, Decodable {
    public let id: Int
    public let title: String
    public let createdAt: String
}

