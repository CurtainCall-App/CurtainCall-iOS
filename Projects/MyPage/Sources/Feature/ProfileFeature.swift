//
//  ProfileFeature.swift
//  MyPage
//
//  Created by 김민석 on 6/16/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct ProfileFeature {
    
    @ObservableState
    public struct State: Equatable {
        public init() { }
    }
    
    public enum Action {
        case fetchUserInfo
        case responseUserInfo(FetchUserInfoResponseDTO)
        case responseError(Error)
    }
    
    @Dependency(\.userClient) var client
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchUserInfo:
                return .run { send in
                    do {
                        try await send(.responseUserInfo(client.fetchUserInfo(UserDefaults.standard.integer(forKey: UserDefaultKeys.userId.rawValue))))
                    } catch {
                        await send(.responseError(error))
                    }
                }
            case .responseUserInfo(let response):
                print(response)
                return .none
            case .responseError(let error):
                return .none
            }
        }
    }
}

