//
//  NicknameSettingFeature.swift
//  NicknameSetting
//
//  Created by 김민석 on 1/23/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct NicknameSettingFeature {
    public init() { }
    
    public struct State: Equatable {
        public init() { }
        @BindingState var nicknameText: String = ""
        
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case duplicatedCheckButtonTapped
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding:
                print(state.nicknameText)
                return .none
            case .duplicatedCheckButtonTapped:
                return .none
            }
            return .none
        }
    }
}
