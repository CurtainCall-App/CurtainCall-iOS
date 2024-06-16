//
//  FetchUserInfoResponseDTO.swift
//  MyPage
//
//  Created by 김민석 on 6/16/24.
//

import Foundation

public struct FetchUserInfoResponseDTO: Decodable, Equatable {
    public let id: Int
    public let nickname: String
    public let imageId: Int?
    public let imageUrl: String?
    public let recruitingNum: Int
}
