//
//  UserClient.swift
//  MyPage
//
//  Created by 김민석 on 6/16/24.
//

import Foundation

import Moya
import ComposableArchitecture

struct UserClient {
    var fetchUserInfo: (Int) async throws -> FetchUserInfoResponseDTO
    var deleteAccount: (DeleteAccountBody) async throws -> Bool
    var saveImage: (Data) async throws -> UploadImageResponse
}

extension UserClient: DependencyKey {
    static var liveValue: UserClient = {
        Self(fetchUserInfo: fetchUserInfo,
            deleteAccount: deleteAccount,
             saveImage: saveImage
        )
    }()
    
    static func fetchUserInfo(id: Int) async throws -> FetchUserInfoResponseDTO {
        try await MoyaProvider<UserAPI>().request(.fetchUserInfo(id: id))
    }
    
    static func deleteAccount(body: DeleteAccountBody) async throws -> Bool {
        try await MoyaProvider<UserAPI>().request(.deleteAccount(body: body))
    }
    static func saveImage(data: Data) async throws -> UploadImageResponse {
        try await MoyaProvider<UserAPI>().request(.saveData(data: data))
    }
    
}

extension DependencyValues {
    var userClient: UserClient {
        get { self[UserClient.self] }
        set { self[UserClient.self] = newValue }
    }
}

