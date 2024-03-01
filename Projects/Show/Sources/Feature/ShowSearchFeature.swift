//
//  ShowSearchFeature.swift
//  Show
//
//  Created by 김민석 on 3/1/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct ShowSearchFeature {
    public init() { }
    
    public struct State: Equatable {
        public init(recentSearches: [String]) {
            self.recentSearches = recentSearches
        }
        @BindingState var showTitleText: String = ""
        var recentSearches: [String]
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case didTappedCancelButton
        case didTappedRemoveRecentSearches(index: Int)
        
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
            case .didTappedRemoveRecentSearches(let index):
                state.recentSearches.remove(at: index)
                UserDefaults.standard.setValue(state.recentSearches, forKey: UserDefaultKeys.showRecentSearches.rawValue)
                return .none
            }
        }
    }
}
