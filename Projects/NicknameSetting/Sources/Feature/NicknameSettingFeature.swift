//
//  NicknameSettingFeature.swift
//  NicknameSetting
//
//  Created by 김민석 on 1/23/24.
//

import Foundation
import Common

import ComposableArchitecture

@Reducer
public struct NicknameSettingFeature {
    public init() { }
    
    public struct State: Equatable {
        public init() { }
        @BindingState var nicknameText: String = ""
        @BindingState var isPossibleNickname: Bool = false
        var isValidCount: Bool = false
        var isValidRegex: Bool = false
        
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case duplicatedCheckButtonTapped
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding(\.$nicknameText):
                state.isValidCount = isValidCount(state.nicknameText)
                state.isValidRegex = isValidRegex(state.nicknameText)
                state.isPossibleNickname = state.isValidCount && state.isValidRegex
                return .none
            case .binding:
                return .none
            case .duplicatedCheckButtonTapped:
                return .none
            }
        }
    }
    
    private func isValidCount(_ nickname: String) -> Bool {
        return !nickname.contains(" ") && (1...15) ~= nickname.count
    }
    
    private func isValidRegex(_ nickname: String) -> Bool {
        return nickname.isValidRegex("^[가-힣a-zA-Z0-9]*$") && !nickname.isEmpty
    }
}
