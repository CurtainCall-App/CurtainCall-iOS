//
//  LoginResponseDTO.swift
//  Login
//
//  Created by 김민석 on 1/19/24.
//

import Foundation

public struct LoginResponseDTO: Decodable {
    let memberId: Int?
    let accessToken: String
    let accessTokenExpiresAt: String
}
