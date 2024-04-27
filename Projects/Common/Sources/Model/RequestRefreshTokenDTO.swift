//
//  RequestRefreshTokenDTO.swift
//  Common
//
//  Created by 김민석 on 4/17/24.
//

import Foundation

public struct RequestRefreshTokenDTO: Decodable {
    let memberId: Int
    let accessToken: String
    let accessTokenExpiresAt: String
    let refreshToken: String
    let refreshTokenExpiresAt: String
}
