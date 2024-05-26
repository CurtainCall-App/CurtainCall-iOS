//
//  FetchNoticeListResponseDTO.swift
//  MyPage
//
//  Created by 김민석 on 5/26/24.
//

import Foundation

public struct FetchNoticeListResponseDTO: Decodable {
    let content: [FetchNoticeListResult]
}

public struct FetchNoticeListResult: Equatable, Decodable {
    let id: Int
    let title: String
    let createdAt: String
}

