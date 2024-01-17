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
        case idTokenReseponse(String)
        case idTokenError(Error)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .appleLoginTapped:
                state.loginType = .apple
                return .none
            case .idTokenReseponse(let token):
                // TODO: - Token 처리
                return .none
                
            case .idTokenError(let error):
                // TODO: - Error 처리
                return .none
            }
            
        }
    }
}
