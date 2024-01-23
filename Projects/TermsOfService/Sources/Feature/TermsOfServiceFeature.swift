//
//  TermsOfServiceFeature.swift
//  Signup
//
//  Created by 김민석 on 1/20/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct TermsOfServiceFeature {
    public init() { }
    
    public struct State: Equatable {
        public init() { }
        
        var isAllCheck: Bool = false
        var isServiceCheck: Bool = false
        var isInfoCheck: Bool = false
        var isAgeCheck: Bool = false
        @BindingState var isPossibleNext: Bool = false
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case allCheckButtonTapped
        case serviceCheckButtonTapped
        case infoCheckButtonTapped
        case ageCheckButtonTapped
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .allCheckButtonTapped:
                state.isAllCheck.toggle()
                state.isServiceCheck = state.isAllCheck
                state.isInfoCheck = state.isAllCheck
                state.isAgeCheck = state.isAllCheck
                state.isPossibleNext = state.isAllCheck
                return .none
            case .serviceCheckButtonTapped:
                state.isServiceCheck.toggle()
                state.isAllCheck = state.isServiceCheck && state.isInfoCheck && state.isAgeCheck
                state.isPossibleNext = state.isAllCheck
                return .none
            case .infoCheckButtonTapped:
                state.isInfoCheck.toggle()
                state.isAllCheck = state.isServiceCheck && state.isInfoCheck && state.isAgeCheck
                state.isPossibleNext = state.isAllCheck
                return .none
            case .ageCheckButtonTapped:
                state.isAgeCheck.toggle()
                state.isAllCheck = state.isServiceCheck && state.isInfoCheck && state.isAgeCheck
                state.isPossibleNext = state.isAllCheck
                return .none
            case .binding:
                return .none
            }
        }
    }
}
