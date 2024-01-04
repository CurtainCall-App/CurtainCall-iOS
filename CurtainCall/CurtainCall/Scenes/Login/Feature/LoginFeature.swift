//
//  LoginFeature.swift
//  CurtainCall
//
//  Created by 김민석 on 1/4/24.
//

import Foundation

import ComposableArchitecture
import AuthenticationServices

@Reducer
struct LoginFeature {
    struct State: Equatable {
    }
    
    enum Action {
        case appleLoginTapped
        case idTokenResponse(String)
        case idTokenError(Error)
    }
    
    @Dependency(\.appleLoginClient) var appleLoginClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .appleLoginTapped:
                return .run { send in
                    try await send(.idTokenResponse(self.appleLoginClient.signIn()))
                }
            case .idTokenResponse(let token):
                print("token: \(token)")
                return .none
            case .idTokenError(let error):
                print("error: \(error.localizedDescription)")
                return .none
            }
        }
    }
}
