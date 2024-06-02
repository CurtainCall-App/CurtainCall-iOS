//
//  FetchNoticeDetailResponseDTO.swift
//  MyPage
//
//  Created by 김민석 on 5/26/24.
//

import Foundation

public struct FetchNoticeDetailResponseDTO: Hashable, Equatable, Decodable {
    let id: Int
    let title: String
    let content: String
    let createdAt: String
}
