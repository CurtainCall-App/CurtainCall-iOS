//
//  DeleteAccountDetailFeature.swift
//  MyPage
//
//  Created by 김민석 on 6/16/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct DeleteAccountDetailFeature {
    
    @ObservableState
    public struct State: Equatable {
        public init(body: DeleteAccountBody) {
            self.body = body
        }
        let body: DeleteAccountBody
        var isSuccessDeleteAccount: Bool = false
        var isFailedDeleteAccount: Bool = false
    }
    
    public enum Action {
        case deleteAccount
        case responseDeleteAccount(Bool)
        case dismissToast
    }
    
    @Dependency(\.userClient) var client
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .deleteAccount:
                return .run { [body = state.body] send in
                    do {
                        try await send(.responseDeleteAccount(client.deleteAccount(body)))
                    } catch {
                        await send(.responseDeleteAccount(false))
                    }
                }
            case .responseDeleteAccount(let isSuccess):
                if isSuccess {
                    state.isSuccessDeleteAccount = true
                } else {
                    state.isFailedDeleteAccount = true
                }
                return .run { send in
                    try await Task.sleep(for: .seconds(1))
                    await send(.dismissToast)
                }.animation()
            case .dismissToast:
                state.isSuccessDeleteAccount = false
                state.isFailedDeleteAccount = false
                return .none
            }
        }
    }
}

