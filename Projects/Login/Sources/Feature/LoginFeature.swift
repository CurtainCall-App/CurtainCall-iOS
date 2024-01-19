//
//  LoginFeature.swift
//  Login
//
//  Created by 김민석 on 1/15/24.
//

import Foundation

import Common
import ComposableArchitecture

@Reducer
public struct LoginFeature {
    public init() { }
    
    public struct State: Equatable {
        public init() { }
        
        var loginType: LoginType?
    }
    
    public enum Action {
        case appleLoginTapped
        case kakaoLoginTapped
        case naverLoginTapped
        case idTokenReseponse(String)
        case idTokenError(Error)
        case requestLogin(Int?)
    }
    
    @Dependency(\.loginClient) var loginClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .appleLoginTapped:
                state.loginType = .apple
                return .run { send in
                    do {
                        try await send(.idTokenReseponse(self.loginClient.signInApple()))
                    } catch {
                        await send(.idTokenError(error))
                    }
                }
            case .kakaoLoginTapped:
                state.loginType = .kakao
                return .run { send in
                    do {
                        try await send(.idTokenReseponse(self.loginClient.signInKakao()))
                    } catch {
                        await send(.idTokenError(error))
                    }
                }
            case .naverLoginTapped:
                state.loginType = .naver
                return .run { send in
                    do {
                        try await send(.idTokenReseponse(self.loginClient.signInNaver()))
                    } catch {
                        await send(.idTokenError(error))
                    }
                }
            case .idTokenReseponse(let token):
                print("token: \(token)")
                return .run { [loginType = state.loginType] send in
                    guard let loginType else { return }
                    try await send(.requestLogin(self.loginClient.requestLogin(loginType, token)))
                }
                
            case .idTokenError(let error):
                print(error.localizedDescription)
                return .none
                
            case .requestLogin(let memberId):
                print("memberId Test: \(memberId)")
                return .none
            }
        
            
        }
    }
}
