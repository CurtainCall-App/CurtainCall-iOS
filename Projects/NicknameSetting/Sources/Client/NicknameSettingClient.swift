//
//  NicknameSettingClient.swift
//  NicknameSetting
//
//  Created by 김민석 on 2/11/24.
//

import Foundation

import Moya
import ComposableArchitecture

public struct NicknameSettingClient {
    public var checkDuplicatedNickname: (String) async throws -> NicknameDuplicatedDTO
    var signup: (String) async throws -> SignupResponseDTO
}

extension NicknameSettingClient: DependencyKey {
    public static var liveValue: NicknameSettingClient = {
        Self(
            checkDuplicatedNickname: checkDuplicatedNickname(nickname:),
            signup: signup(nickname:)
        )
    }()
    
    public static func checkDuplicatedNickname(nickname: String) async throws -> NicknameDuplicatedDTO {
        return try await MoyaProvider<NicknameAPI>().request(.duplicatedNickname(nickname))
    }
    static func signup(nickname: String) async throws -> SignupResponseDTO {
        return try await MoyaProvider<NicknameAPI>().request(.signup(nickname))
    }
}

extension DependencyValues {
    public var nicknameSettingClient: NicknameSettingClient {
        get { self[NicknameSettingClient.self] }
        set { self[NicknameSettingClient.self] = newValue }
    }
}
