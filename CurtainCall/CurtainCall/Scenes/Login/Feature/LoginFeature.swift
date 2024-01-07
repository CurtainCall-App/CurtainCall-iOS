//
//  LoginFeature.swift
//  CurtainCall
//
//  Created by 김민석 on 1/4/24.
//

import Foundation

import ComposableArchitecture

@Reducer
struct LoginFeature {
    struct State: Equatable {
        var loginType: LoginType = .apple
    }
    
    enum Action {
        case appleLoginTapped
        case idTokenResponse(String)
        case idTokenError(Error)
        case requestLogin(Bool)
    }
    
    @Dependency(\.loginClient) var loginClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .appleLoginTapped:
                state.loginType = .apple
                return .run { send in
                    try await send(.idTokenResponse(self.loginClient.signInApple()))
                }
            case .idTokenResponse(let token):
                print("token: \(token)")
                return .run { [loginType = state.loginType] send in
                    if loginType == .apple {
                        try await send(.requestLogin(self.loginClient.requestLogin(token)))
                    }
                    // TODO: 다른소셜로그인 처리
                }
            case .idTokenError(let error):
                print("error: \(error.localizedDescription)")
                return .none
            case .requestLogin(let islogin):
                print("isLoggin: \(islogin)")
                return .none
            }
        }
    }
}
