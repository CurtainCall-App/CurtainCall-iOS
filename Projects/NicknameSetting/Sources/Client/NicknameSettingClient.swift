//
//  NicknameSettingClient.swift
//  NicknameSetting
//
//  Created by 김민석 on 2/11/24.
//

import Foundation

import Moya
import ComposableArchitecture

struct NicknameSettingClient {
    var checkDuplicatedNickname: (String) async throws -> NicknameDuplicatedDTO
    var signup: (String) async throws -> SignupResponseDTO
}

extension NicknameSettingClient: DependencyKey {
    static var liveValue: NicknameSettingClient = {
        Self(
            checkDuplicatedNickname: checkDuplicatedNickname(nickname:),
            signup: signup(nickname:)
        )
    }()
    
    static func checkDuplicatedNickname(nickname: String) async throws -> NicknameDuplicatedDTO {
        return try await MoyaProvider<NicknameAPI>().request(.duplicatedNickname(nickname))
    }
    static func signup(nickname: String) async throws -> SignupResponseDTO {
        return try await MoyaProvider<NicknameAPI>().request(.signup(nickname))
    }
}

extension DependencyValues {
    var nicknameSettingClient: NicknameSettingClient {
        get { self[NicknameSettingClient.self] }
        set { self[NicknameSettingClient.self] = newValue }
    }
}
