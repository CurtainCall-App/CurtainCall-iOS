//
//  ShowSearchFeature.swift
//  Show
//
//  Created by 김민석 on 3/1/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct ShowSearchFeature {
    public init() { }
    
    public struct State: Equatable {
        public init() { }
        @BindingState var showTitleText: String = ""
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case didTappedCancelButton
        
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding(\.$showTitleText):
                return .none
            case .binding:
                return .none
            case .didTappedCancelButton:
                return .none
            }
        }
    }
}
