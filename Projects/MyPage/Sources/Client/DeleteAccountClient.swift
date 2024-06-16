//
//  DeleteAccountClient.swift
//  MyPage
//
//  Created by 김민석 on 6/16/24.
//

import Foundation

import Moya
import ComposableArchitecture

struct DeleteAccountClient {
    var deleteAccount: (DeleteAccountBody) async throws -> Bool
}

extension DeleteAccountClient: DependencyKey {
    static var liveValue: DeleteAccountClient = {
        Self(deleteAccount: deleteAccount)
    }()
    
    static func deleteAccount(body: DeleteAccountBody) async throws -> Bool {
        try await MoyaProvider<DeleteAccountAPI>().request(.deleteAccount(body: body))
    }
    
}

extension DependencyValues {
    var deleteAccountClient: DeleteAccountClient {
        get { self[DeleteAccountClient.self] }
        set { self[DeleteAccountClient.self] = newValue }
    }
}
